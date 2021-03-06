library(McMasterPandemic)

source("run_params.R")

seed <- 101
set.seed(seed)

simdat <- forecast_sim(p=true_pars
                     , opt_pars = opt_pars
                     , base_params = params
                     , start_date=start_date
                     , end_date=end_date
                     , break_dates = bd
                                        # , rel_beta0= rel_break1
                     , stoch = c(obs = TRUE, proc=FALSE)
                       )
## plot(simdat, log=TRUE)
simdat <- (simdat
    %>% filter(var %in% c("report"))
    %>% filter(!is.na(value)) 
    %>% mutate(value = round(value))
)

simdat <- simdat %>% filter(between(date, cut_start, cut_end))

plot(ggplot(simdat,aes(date,value))+geom_point()+scale_y_log10())

## print(params)
## print(opt_pars)
g1 <- calibrate(data=simdat, base_params=params
              , start_date = start_date
              , opt_pars = opt_pars
              , break_dates = bd
                ## , debug_plot=TRUE
                ## , debug=FALSE
                ## , mle2_args=list(browse_obj=TRUE)
                )

print(bbmle::coef(g1$mle2))

pp <- predict(g1)

res_dat <- data.frame(bbmle::confint(g1$mle2, method="quad", level=0.95)
                    , estimate = bbmle::coef(g1$mle2)
                    , seed = seed
                    , pars = names(g1$mle2@coef)
                      )
print(true_pars)
print(res_dat)

pps1 <- predict(g1, ensemble=TRUE)
plot(pps1)
try(pps2 <- predict(g1, ensemble=TRUE, imp_wts=TRUE))

load("../ontario/ontario_calibration_noICU_2brks_prior.RData")
pps3 <- predict(ont_cal_noICU_2brks_prior, ensemble=TRUE, end_date="2020-06-01")
plot(pps3)
## pps4 <- predict(ont_cal_noICU_2brks_prior, ensemble=TRUE, end_date="2020-06-01",
##                 imp_wts=TRUE)
