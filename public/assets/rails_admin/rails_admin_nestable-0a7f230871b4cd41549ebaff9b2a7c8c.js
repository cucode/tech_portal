(function() {
  jQuery(function() {
    var $live_update, $tree_nodes, $tree_nodes_max_depth, $tree_nodes_options, $update_button, live_update_mode, updateNodes;
    updateNodes = function(tree_nodes) {
      var serialized_tree;
      serialized_tree = tree_nodes.nestable('serialize');
      return $.ajax({
        url: tree_nodes.data('update-path'),
        type: 'POST',
        data: {
          tree_nodes: serialized_tree
        },
        success: function(data) {
          var $flash;
          $flash = $('<div>').addClass('nestable-flash alert').append($('<button>').addClass('close').data('dismiss', 'alert').html('&times;')).append($('<span>').addClass('body').html(data));
          $('#rails_admin_nestable').append($flash);
          return $flash.fadeIn(200).delay(2000).fadeOut(200, function() {
            return $(this).remove();
          });
        }
      });
    };
    $tree_nodes = $('#tree_nodes');
    $tree_nodes_options = {};
    $tree_nodes_max_depth = $tree_nodes.data('max-depth');
    $live_update = $('#rails_admin_nestable input[type=checkbox]');
    $update_button = $('#rails_admin_nestable button');
    live_update_mode = $live_update.prop('checked');
    $('#rails_admin_nestable button').prop('disabled', $live_update.prop('checked'));
    $live_update.change(function() {
      live_update_mode = $(this).prop('checked');
      return $update_button.prop('disabled', live_update_mode);
    });
    $update_button.click(function() {
      return updateNodes($tree_nodes);
    });
    if ($tree_nodes_max_depth && $tree_nodes_max_depth !== 'false') {
      $tree_nodes_options['maxDepth'] = $tree_nodes_max_depth;
    }
    return $tree_nodes.nestable($tree_nodes_options).on({
      change: function(event) {
        if (live_update_mode) {
          return updateNodes($tree_nodes);
        }
      }
    });
  });

}).call(this);
