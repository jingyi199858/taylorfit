

const csv = require('fast-csv');
const math = require('./math.jsx');


module.exports = (path, removeHeader, callback) => {
  var data = [];

  if (removeHeader instanceof Function) {
    callback = removeHeader;
    removeHeader = false;
  }

  csv.fromPath(path)
    .on('data', (row) => {
      if (removeHeader) {
        removeHeader = false;
        return;
      }
      data.push(row.map((x) => parseInt(x)));
    })
    .on('end', () => callback(math.matrix(data)));
};

