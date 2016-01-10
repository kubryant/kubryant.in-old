/*
 * default error handler if route is not found
 */

function render(req, res) {
  let err = new Error('Not Found');
  err.status = 404;
  res.status(err.status);

  // don't display error and stack on production
  if(process.env.NODE_ENV === 'production') {
    err.status = '';
    err.stack = '';
  }

  res.render('error', {
    message: err.message,
    error: err
  });
}

export default render;
