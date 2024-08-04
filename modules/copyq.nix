{
  lib,
  config,
  ...
}: {
  options.copyq.enable = lib.mkEnableOption "enable copyq";

  config = lib.mkIf config.copyq.enable {
    services.copyq.enable = true;

    home.file.".config/copyq/themes/gruvbox.ini".text = with config.lib.stylix.colors.withHashtag; ''
      [General]
      alt_bg=${base01}
      alt_item_css=
      bg=${base00}
      css=
      css_template_items=items
      css_template_main_window=main_window
      css_template_menu=menu
      css_template_notification=notification
      cur_item_css="\n    ;border: 0.1em solid ''${sel_bg}"
      edit_bg=${base00}
      edit_fg=${base07}
      edit_font="JetBrainsMonoNL NFM,11,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Regular"
      fg=${base07}
      find_bg=${base08}
      find_fg=${base00}
      find_font="JetBrainsMonoNL NFM,11,-1,5,300,1,0,0,0,0,0,0,0,0,0,1,Italic"
      font="JetBrainsMonoNL NFM,11,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Regular"
      font_antialiasing=true
      hover_item_css=
      icon_size=16
      item_css=
      item_spacing=
      menu_bar_css="\n    ;background: ''${bg}\n    ;color: ''${fg}"
      menu_bar_disabled_css="\n    ;color: ''${bg - #666}"
      menu_bar_selected_css="\n    ;background: ''${sel_bg}\n    ;color: ''${sel_fg}"
      menu_css="\n    ;border: 1px solid ''${sel_bg}\n    ;background: ''${bg}\n    ;color: ''${fg}"
      notes_bg=${base00}
      notes_css=
      notes_fg=${base07}
      notes_font="JetBrainsMonoNL NFM,11,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Regular"
      notification_bg=${base00}
      notification_fg=#ddd
      notification_font="JetBrainsMonoNL NFM,9,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Regular"
      num_fg=${base07}
      num_font="JetBrainsMonoNL NFM,8,-1,5,500,0,0,0,0,0,0,0,0,0,0,1,Regular"
      num_margin=2
      search_bar="\n    ;background: ''${edit_bg}\n    ;color: ''${edit_fg}\n    ;border: 1px solid ''${alt_bg}\n    ;margin: 2px"
      search_bar_focused="\n    ;border: 1px solid ''${sel_bg}"
      sel_bg=${base03}
      sel_fg=${base07}
      sel_item_css=
      show_number=true
      show_scrollbars=false
      style_main_window=true
      tab_bar_css="\n    ;background: ''${bg - #222}"
      tab_bar_item_counter="\n    ;color: ''${fg - #044 + #400}\n    ;font-size: 6pt"
      tab_bar_scroll_buttons_css="\n    ;background: ''${bg - #222}\n    ;color: ''${fg}\n    ;border: 0"
      tab_bar_sel_item_counter="\n    ;color: ''${sel_bg - #044 + #400}"
      tab_bar_tab_selected_css="\n    ;padding: 0.5em\n    ;background: ''${bg}\n    ;border: 0.05em solid ''${bg}\n    ;color: ''${fg}"
      tab_bar_tab_unselected_css="\n    ;border: 0.05em solid ''${bg}\n    ;padding: 0.5em\n    ;background: ''${bg - #222}\n    ;color: ''${fg - #333}"
      tab_tree_css="\n    ;color: ''${fg}\n    ;background-color: ''${bg}"
      tab_tree_item_counter="\n    ;color: ''${fg - #044 + #400}\n    ;font-size: 6pt"
      tab_tree_sel_item_counter="\n    ;color: ''${sel_fg - #044 + #400}"
      tab_tree_sel_item_css="\n    ;color: ''${sel_fg}\n    ;background-color: ''${sel_bg}\n    ;border-radius: 2px"
      tool_bar_css="\n    ;color: ''${fg}\n    ;background-color: ''${bg}\n    ;border: 0"
      tool_button_css="\n    ;color: ''${fg}\n    ;background: ''${bg}\n    ;border: 0\n    ;border-radius: 2px"
      tool_button_pressed_css="\n    ;background: ''${sel_bg}"
      tool_button_selected_css="\n    ;background: ''${sel_bg - #222}\n    ;color: ''${sel_fg}\n    ;border: 1px solid ''${sel_bg}"
      use_system_icons=true
    '';
  };
}
