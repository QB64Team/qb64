(function($){

  $.fn.enableFolding = function(autofold, snap) {
    var fragId = document.location.hash;
    if (fragId && /^#no\d+$/.test(fragId))
      fragId = parseInt(fragId.substr(3));
    if (snap == undefined)
      snap = false;
    
    var count = 1;
    return this.each(function() {
      // Use first child <a> as a trigger, or generate a trigger from the text
      var trigger = $(this).children("a").eq(0);
      if (trigger.length == 0) {
        trigger = $("<a" + (snap? " id='no" + count + "'": "")
            + " href='#no" + count + "'></a>");
        trigger.text($(this).text());
        $(this).text("");
        $(this).append(trigger);
      }
      
      trigger.click(function() {
        var div = $(this.parentNode.parentNode).toggleClass("collapsed");
        return snap && !div.hasClass("collapsed");
      });
      if (autofold && (count != fragId))
        trigger.parents().eq(1).addClass("collapsed");
      count++;
    });
  }

  /** Enable columns of a table to be hidden by clicking on the column header.
   *
   * +------------------+------+---- ... ---+---------------------+
   * |column_headers[0] | ...  |            | column_headers[k-1] | <- c_h_row
   * +==================+======+==== ... ===+=====================+
   * | row_headers[0]   | row_headers[1]    | row_headers[1*k-1]  | <- rows[0]
   * | row_headers[k]   | row_headers[k+1]  | row_headers[2*k-1]  | <- rows[1]
   * ...
   */
  $.fn.enableCollapsibleColumns = function(recovery_area) {
    // column headers
    var c_h_row = $('thead tr', this);
    var column_headers = $('th', c_h_row).not(recovery_area);
    var k = column_headers.length;
    // row headers
    var tbody = $('tbody', this);
    var row_headers = $('th', tbody);
    var rows = $('tr', tbody);
    var n = row_headers.length / k;

    // add a 'hide' callback to each column header
    column_headers.each(function(j) {
        function hide() {
          // remove and save column j
          var th = $(this);
          th.css('display', 'none');
          for ( var i = 0; i < n; i++ )
            row_headers.eq(i*k+j).css('display', 'none');
          // create a recovery button and its "show" callback
          recovery_area.prepend($("<span></span>").addClass("recover")
            .text(babel.format(_("Show %(title)s"), {title: th.text()}))
            .click(function() {
              $(this).remove();
              th.show();
              if ($.browser.msie)
                for ( var i = 0; i < n; i++ )
                  row_headers.eq(i*k+j).show();
              else // much faster, but not supported by IExplorer
                for ( var i = 0; i < n; i++ )
                  row_headers.eq(i*k+j).css('display', 'table-cell');
            })
          );
        };
        $(this).click(hide)
          .css('cursor', 'pointer')
          .attr('title', babel.format(_("%(title)s (click to hide column)"),
                                      {title: $(this).attr('title')}));
      });
  }

})(jQuery);
