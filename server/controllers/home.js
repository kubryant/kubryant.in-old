/*
 * controller to handle the main content
 */

function render(req, res) {
  res.render('index', {
    title: 'Under construction',
    description: 'Stay tuned.'
  });
}

export default render;
