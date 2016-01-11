/*
 * controller to handle the home page
 */

function render(req, res) {
  res.render('home', {
    title: 'Under construction',
    description: 'Stay tuned.'
  });
}

export default render;
