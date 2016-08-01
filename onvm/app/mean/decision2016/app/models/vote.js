// app/models/nerd.js
// grab the mongoose module
var mongoose = require('mongoose');

// define our nerd model
// module.exports allows us to pass this to other files when it is called
module.exports = mongoose.model('Vote', {
    ssn : {type : String, default: ''},
    name : {type : String, default: ''},
    zipcode : {type : String, default: ''}
});
