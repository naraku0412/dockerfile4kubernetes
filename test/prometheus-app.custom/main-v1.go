package main

import (
    "log"
    "flag"
    "net/http"
    "math/rand"
    "time"

    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
    portFlag = flag.String("p",":8080","working port, in term of :8080")
    periodFlag = flag.Int("period",10,"period of the data generation")
)
var (
    cpuTemp = prometheus.NewGauge(prometheus.GaugeOpts{
        Name: "cpu_temperature_celsius",
        Help: "Current temperature of the CPU.",
    })
    hdFailures = prometheus.NewCounterVec(
        prometheus.CounterOpts{
            Name: "hd_errors_total",
            Help: "Number of hard-disk errors.",
        },
        []string{"device"},
    )
)

func init() {
    // Metrics have to be registered to be exposed:
    prometheus.MustRegister(cpuTemp)
    prometheus.MustRegister(hdFailures)
}

func main() {
    flag.Parse()
    cpuTemp.Set(65.3)
    hdFailures.With(prometheus.Labels{"device":"/dev/sda"}).Inc()

    go func() {
        for {
            v := rand.Float64()    
            cpuTemp.Set(v)
            time.Sleep(time.Duration(*periodFlag)*time.Second)
        }
    }()
    // The Handler function provides a default handler to expose metrics
    // via an HTTP server. "/metrics" is the usual endpoint for that.
    http.Handle("/metrics", promhttp.Handler())
    log.Fatal(http.ListenAndServe(*portFlag, nil))
}
