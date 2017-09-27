package com.iqmsoft.kotlin.spark.docker

import spark.Spark.*

fun main(args: Array<String>) {

    get("/echo", { req, res ->
        "Hello, ${req.queryParams("name")}!"
    })

}
