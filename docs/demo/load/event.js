


window.addEventListener('onLoadUpdate', function (e) {
  // console.warn(e);
  console.warn('load update (one element loaded)');
}, true);


window.addEventListener('onLoadReady', function (e) {
  // console.warn(e);
  console.warn('load ready (all object loaded)');
}, true);