
/*
 * GET home page.
 */

var config = require('../config.js')

exports.index = function(req, res){
  res.render('index', config.web)
};

exports.distribution = function(req, res) {
  res.render('distribution', config.web)
}
