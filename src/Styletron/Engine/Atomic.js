"use strict";

var styletronEngineAtomic = require("styletron-engine-atomic")

exports.mkClient = function () {
    return new styletronEngineAtomic.Client()
}