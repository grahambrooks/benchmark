(ns clojure-benchmark.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.util.response :refer [response]]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]
            [ring.middleware.json :refer [wrap-json-response]]))

(defn benchmark
  []
  {:results (take 10 (into [] (for [i (range 1000000)] (str "index " i))))})

(defroutes app-routes
           (GET "/framework" [] (response {:hello "world"}))
           (GET "/benchmark" [] (response (benchmark)))
           (route/not-found "Not Found"))

(def app
  (-> app-routes
      (wrap-json-response {:keywords? true :bigdecimals? true})
      (wrap-defaults site-defaults)))
;;(wrap-defaults app-routes site-defaults)
