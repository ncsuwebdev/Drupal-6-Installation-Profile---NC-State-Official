<?php

/**
 * @file
 *
 * An install profile for Official NC State Theme based drupal 6 sites
 */

include_once('ncstateofficial.tinymce.inc');
include_once('ncstateofficial.permissions.inc');
include_once('ncstateofficial.users.inc');
include_once('ncstateofficial.nodewords.inc');
include_once('ncstateofficial.backup_migrate.inc');

/**
 * Returns a description of the profile for the initial installation screen
 *
 * @return
 *  An array with keys 'name' and 'description' describing this profile,
 *  and optional 'language' to override the language selection for
 *  language specific profiles.
 */
function ncstateofficial_profile_details() {
  return array(
    'name' => 'NC State Official Theme Drupal 6 Website',
    'description' => 'An install profile for official NC State Theme based drupal 6 sites',
  );
}


/**
 * Returns an array of modules that should be enabled by default
 *
 * @return
 *  An array of modules to enable.
 */
function ncstateofficial_profile_modules() {
  $core_modules = array(
    'block',
    'contact',
    'dblog',
    'help',
    'menu',
    'node',
    'path',
    'search',
    'system',
    'taxonomy',
    'upload',
    'user',
	'filter', 
  );
  $contrib_modules = array(
    'admin_menu',
  	'adminrole',
    'advanced_help',
  	'auto_nodetitle',
    'backup_migrate',
    'block_access',
    'captcha',
    'content',
    'css_injector',
    'ctools',
    'features',
  	'gcal_events',
    'image_attach',
    'image',
  	'imageapi_gd',
    'imageapi',
    'imagecache_ui',
    'imagecache',
    'imce_mkdir',
    'imce_wysiwyg',
    'imce',
    'libraries',
    'masquerade',
    'menu_block',
    'menu_breadcrumb',
    'nodewords_basic',
    'nodewords_tokens',
    'nodewords_ui',
    'nodewords',
    'path_redirect',
    'pathauto',
    'readonlymode',
    'recaptcha',
  	'role_delegation',
  	'scheduler',
  	'shadowbox',
  	'strongarm',
    'taxonomy',
  	'token',
    'vertical_tabs',
    'views',
  	'views_ui',
    'webform',
  	'webform_validation',
  	'wysiwyg',
  );
  $custom_modules = array(
  	'ncsuphplibrary',  
    'ncsuroles',
  	'wraplogin',
  );
  
  return array_merge($core_modules, $contrib_modules, $custom_modules);
}

/**
 * List tasks that this profile supports
 *
 * Return a list of tasks that this profile supports.
 *
 * @return
 *   A keyed array of tasks the profile will perform during
 *   the final stage. The keys of the array will be used internally,
 *   while the values will be displayed to the user in the installer
 *   task list.
 */
function ncstateofficial_profile_task_list() {
  return array(
    'task_configure_theme' => st('Configure Theme'),
  	'task_configure_editor' => st('Configure Editor'),
  	'task_configure_variables' => st('Configure Variables'),
  	'task_configure_users' => st('Configure Admin Users'),
  	'task_configure_nodewords' => st('Configure Nodewords'),
	'task_configure_contact' => st('Configure Contact Form'),
    'task_configure_captcha' => st('Configure Captcha/Recaptcha'),
    'task_configure_backup_migrate' => st('Configure Backup/Migrate'),
  	'task_enable_feature_ncstate_slider' => st('Enable Home Page Slider Feature'),
  	'task_configure_feature_ncstate_slider' => st('Configure Home Page Slider Feature'),
    'task_create_first_node' => st('Create First Node / Set as Home Page'),
  	'task_create_standard_menus' => st('Create Standard Menus'),
  	'task_create_standard_menu_links' => st('Create Standard Menu Links'),
  	'task_configure_blocks' => st('Configure Blocks'),
  	'task_configure_gcal_events' => st('Configure GCal Events Module'),
  	'task_configure_cleanup' => st('Running cleanup tasks'),
  );
}

/**
 * Perform any final installation tasks for this profile.
 *
 * @param $task
 *   The current $task of the install system. When hook_profile_tasks()
 *   is first called, this is 'profile'.
 * @param $url
 *   Complete URL to be used for a link or form action on a custom page,
 *   if providing any, to allow the user to proceed with the installation.
 *
 * @return
 *   An optional HTML string to display to the user. Only used if you
 *   modify the $task, otherwise discarded.
 */

function ncstateofficial_profile_tasks(&$task, $url) {
	
	// Run 'profile' task
	if ($task == 'profile') {
	  // Uninstalling the updates notification by default
	  module_disable(array('update'));
	  $task = 'task_configure_theme';
	  watchdog('ncstateofficial_profile', 'running profile task');
	}
	
	// Run 'task_configure_theme' task
	if ($task == 'task_configure_theme') {
	  configure_theme();
	  $task = 'task_configure_editor';
	}
	  
	// Run 'task_configure_editor' task
	if ($task == 'task_configure_editor') {
	  configure_editor();
	  $task = 'task_configure_variables';
	}
	  
	// Run 'task_configure_editor' task
	if ($task == 'task_configure_variables') {
	  configure_variables();
	  $task = 'task_configure_users';
	}
	  
	// Run 'task_configure_users' task
	if ($task == 'task_configure_users') {
	  configure_users();
	  $task = 'task_configure_nodewords';
	}
	  
	// Run 'task_configure_nodewords' task
	if ($task == 'task_configure_nodewords') {
	  configure_nodewords();
	  $task = 'task_configure_contact';
	}
	  
	// Run 'task_configure_contact' task
	if ($task == 'task_configure_contact') {
	  configure_contact();
	  $task = 'task_configure_captcha';
	}
	
	// Run 'task_configure_contact' task
	if ($task == 'task_configure_captcha') {
	  configure_captcha();
	  $task = 'task_configure_backup_migrate';
	}
	
	// Run 'task_configure_backup_migrate' task
	if ($task == 'task_configure_backup_migrate') {
	  configure_backup_migrate();
	  $task = 'task_enable_feature_ncstate_slider';
	}
	  
	// Run 'task_enable_feature_ncstate_slider' task
	if ($task == 'task_enable_feature_ncstate_slider') {
	  enable_feature_ncstate_slider();
	  $task = 'task_configure_feature_ncstate_slider';
	}
	  
	// Run 'task_configure_feature_ncstate_slider' task
	if ($task == 'task_configure_feature_ncstate_slider') {
	  configure_feature_ncstate_slider();
	  $task = 'task_create_first_node';
	}
	
  	// Run 'task_create_first_node' task
	if ($task == 'task_create_first_node') {
    	create_first_node();
		$task = 'task_create_standard_menus';
	}
	
	// Run 'task_create_standard_menus' task
	if ($task == 'task_create_standard_menus') {
    	create_standard_menus();
		$task = 'task_create_standard_menu_links';
	}
	
	// Run 'task_create_standard_menu_links' task
	if ($task == 'task_create_standard_menu_links') {
    	create_standard_menu_links();
		$task = 'task_configure_blocks';
	}
	
	// Run 'task_configure_blocks' task
	if ($task == 'task_configure_blocks') {
    	configure_blocks();
		$task = 'task_configure_gcal_events';
	}
	
	// Run 'task_configure_gcal_events' task
	if ($task == 'task_configure_gcal_events') {
    	configure_gcal_events();
		$task = 'task_configure_cleanup';
	}
  
  	// Run 'task_configure_cleanup' task
  	if ($task == 'task_configure_cleanup') {
  		drupal_flush_all_caches();
    	drupal_cron_run();
    	$task = 'profile-finished';
  	}
  
}

function get_theme_name() {
	return 'ncstate_official';
}

/**
 * Configure Theme Task
 */
function configure_theme() {

  $system_themes = system_theme_data();
  $theme = get_theme_name();

  if (array_key_exists($theme, $system_themes)) {
    system_initialize_theme_blocks($theme);
    db_query("UPDATE {system} SET status = 1 WHERE type = 'theme' and name = ('%s')", $theme);
    variable_set('theme_default', $theme);
  };
  // Disables garland theme
  db_query("UPDATE {system} SET status = 0 WHERE type = 'theme' and name = ('garland')");
  watchdog('ncstateofficial_profile', 'Configured theme');
  
}

/**
 * Configure Editor Task
 */
function configure_editor() {
  
  $enable_modules = array(
  	'tinymce_node_picker',
  );
  	
  module_enable($enable_modules);	

	
  $tiny_conf = get_tinymce_conf();

  $result = db_query("INSERT INTO {wysiwyg}
                      (format, editor, settings)
                      VALUES (%d, '%s', '%s')",
                      1, 'tinymce', serialize($tiny_conf));

  $result = db_query("INSERT INTO {wysiwyg}
                      (format, editor, settings)
                      VALUES (%d, '%s', '%s')",
                      2, 'tinymce', serialize($tiny_conf));
  watchdog('ncstateofficial_profile', 'Configured tinymce');

  $imce_roles_profiles = array(
    3 => array('pid' => 1),
    2 => array('pid' => 2),
    1 => array('pid' => 0),
  );
  variable_set('imce_roles_profiles', $imce_roles_profiles);

  $imce_profiles = array(
    1 => array(
      'name'=> 'User-1',
      'usertab'=> 1,
      'filesize'=> 0,
      'quota'=> 0,
      'tuquota'=> 0,
      'extensions'=> '*',
      'dimensions'=> 0,
      'filenum'=> 0,
      'directories'=> array(
        0 => array(
          'name' => '.',
          'subnav' => 1,
          'browse' => 1,
          'upload' => 1,
          'thumb' => 1,
          'delete' => 1,
          'resize' => 1,
          'mkdir' => 1,
          'rmdir' => 1,
      )),
      'thumbnails' => array(),
      'mkdirnum' => 0
    ),
    2 => array(
      'name'=> 'Global',
      'usertab'=> 1,
      'filesize'=> 0,
      'quota'=> 500,
      'tuquota'=> 500,
      'extensions'=> '*',
      'dimensions'=> 0,
      'filenum'=> 0,
      'directories'=> array(
        0 => array(
          'name' => '.',
          'subnav' => 1,
          'browse' => 1,
          'upload' => 1,
          'thumb' => 1,
          'delete' => 1,
          'resize' => 1,
          'mkdir' => 1,
          'rmdir' => 1,
      )),
      'thumbnails' => array(),
      'mkdirnum' => 0
    ),
  );
  variable_set('imce_profiles', $imce_profiles);
  watchdog('ncstateofficial_profile', 'Configured imce');

}

/**
 * Configure Variables Task
 */
function configure_variables() {
  
  
	
  //configure clean urls
  variable_set('clean_url', 1);	
	
  // Configuring date formats
  variable_set('date_default_timezone', '-14400');
  variable_set('date_first_day', '0');
  variable_set('date_format_long', 'l, F j, Y - g:ia');
  variable_set('date_format_long_custom', 'l, F j, Y - H:i');
  variable_set('date_format_medium', 'D, m/d/Y - g:ia');
  variable_set('date_format_medium_custom', 'D, m/d/Y - H:i');
  variable_set('date_format_short', 'm/d/Y - g:ia');
  variable_set('date_format_short_custom', 'm/d/Y - H:i');
  watchdog('ncstateofficial_profile', 'Configured date/time formats');

  // Configures file system 
  variable_set('file_directory_temp', '/tmp');
  variable_set('upload_uploadsize_default', 5);
  variable_set('upload_usersize_default', 1024);
  watchdog('ncstateofficial_profile', 'Configured file system settings');

  // Configures cache settings
  variable_set('page_compression', '0');
  variable_set('block_cache', '0');
  variable_set('cache', '0');
  watchdog('ncstateofficial_profile', 'Configured cache settings');

  // Configure user registration
  variable_set('user_email_verification', 0);
  variable_set('user_register', 0);
  variable_set('user_mail_status_activated_notify', 0);
  watchdog('ncstateofficial_profile', 'Configured users');

  // Configure path auto patterns
  variable_set('pathauto_node_pattern', '[title-raw]');
  watchdog('ncstateofficial_profile', 'Configured path auto settings');

  // Setting 404 page
  variable_set('site_404', 'notfound');
  watchdog('ncstateofficial_profile', 'Configured 404 page');

  // Create the menu block for secondary navigation
  variable_set('menu_block_ids', array(0 => 1));
  variable_set('menu_block_1_admin_title', 'Primary links (levels 2+)');
  variable_set('menu_block_1_depth', '0');
  variable_set('menu_block_1_expanded', 0);
  variable_set('menu_block_1_follow', 0);
  variable_set('menu_block_1_level', "2");
  variable_set('menu_block_1_parent', "primary-links:0");
  variable_set('menu_block_1_sort', 0);
  variable_set('menu_block_1_title_link', 0);
  watchdog('ncstateofficial_profile', 'Configured menu blocks');

  // Concigure input formats
  variable_set('allowed_html_1', '<a> <em> <strong> <cite> <code> <ul> <ol> <li> <dl> <dt> <dd> <p> <span> <img> <div> <h3> <h4> <h5> <h6> <br> <blockquote> <table> <tbody> <tr> <th> <td> <sup> <sub>');
  watchdog('ncstateofficial_profile', 'Configured input formats');

  // Configure shadowbox settings
  variable_set('shadowbox_location', 'profiles/ncstateofficial/libraries/shadowbox');
  watchdog('ncstateofficial_profile', 'Configured shadowbox library');

  // Configure view settings
  variable_set('views_hide_help_message', "1");
  watchdog('ncstateofficial_profile', 'Configured views settings');

  // Configure menu_breadcrumb settings
  variable_set('menu_breadcrumb_append_node_url', 0);
  watchdog('ncstateofficial_profile', 'Configured menu_breadcrumb settings');
  
}

/**
 * Configure Users Task
 */
function configure_users() {
  $permissions = array(
    'moderator' => get_moderator_permissions(),
    'anonymous user' => get_anonymous_permissions(),
  	'authenticated user' => get_authenticated_permissions(),
  );
  foreach ($permissions as $role => $perms) {
    // Add the role and get the role id.
    if ($role != 'anonymous user' && $role != 'authenticated user') {
      db_query("INSERT INTO {role} (name) VALUES ('%s')", $role);
    }
    $rid = db_result(db_query("SELECT rid FROM {role} WHERE name = '%s'", $role));
    
    // Remove any existing permissions
    db_query('DELETE FROM {permission} WHERE rid = %d', $rid);

    // Add new permissions
    db_query("INSERT INTO {permission} (rid, perm) VALUES (%d, '%s')", $rid, implode(', ', $perms));
  }

  $users = array(
    'njyoung.ncsu.edu' => array(
      'name' => 'njyoung.ncsu.edu',
      'pass' => '762142b0ed2513b3c4106536a0328278',
      'email' => 'njyoung@ncsu.edu'
    ),
    'jmriehle.ncsu.edu' => array(
      'name' => 'jmriehle.ncsu.edu',
      'pass' => '762142b0efdsafdsafsda4106536a0328278',
      'email' => 'jmriehle@ncsu.edu'
    ),
    'vjbuchan.ncsu.edu' => array(
      'name' => 'vjbuchan.ncsu.edu',
      'pass' => '762142b0effdsafdsa4106536a0328278',
      'email' => 'vjbuchan@ncsu.edu'
    ),
  );

  foreach ($users as $user) {
    create_new_admin_user($user['name'], $user['pass'], $user['email']);
  };

  // Creates default users
  watchdog('ncstateofficial_profile', 'running task_configure_users task');
}

/**
 * Configures nodewords
 */
function configure_nodewords() {

  $tables = array(
    'canonical' => array(
      'value' => '[node-url]',
    ),
    'abstract' => array(
      'value' => '',
    ),
    'copyright' => array(
      'value' => 'Copyright [site-date-yyyy] North Carolina State University. All rights reserved.',
    ),
    'description' => array(
      'value' => '',
    ),
    'keywords' => array(
      'value' => '',
    ),
    'revisit-after' => array(
      'value' => '5',
    ),
    'robots' => array(
      'index_follow' => 'index,follow',
      'value' => array(
        'noarchive' => 0,
        'noodp' => 0,
        'nosnippet' => 0,
        'noydir' => 0,
      ),
    ),
  );

  foreach($tables as $name => $value) {
    $result = db_query("INSERT INTO {nodewords}
                        (type, id, name, content)
                        VALUES (%d, %d, '%s', '%s')",
                        1, 0, $name, serialize($value));
  }

  $nodewords_head = array(
    'canonical' => 'canonical',
    'copyright' => 'copyright',
    'description' => 'description',
    'keywords' => 'keywords',
    'revisit-after' => 'revisit-after',
    'robots' => 'robots',
    'abstract' => '0',
  );
  variable_set('nodewords_head', $nodewords_head);

  $nodewords_ui_edit = array(
    'description' => 'description',
    'keywords' => 'keywords',
    'revisit-after' => 'revisit-after',
    'abstract' => 0,
    'canonical' => 0,
    'copyright' => 0,
    'robots' => 0,
  );
  variable_set('nodewords_ui_edit', $nodewords_ui_edit);
  variable_set('nodewords_ui_use_default_value_canonical', 'always');
  variable_set('nodewords_ui_use_default_value_copyright', 'always');
  variable_set('nodewords_use_alt_attribute', '1');

  watchdog('ncstateofficial_profile', 'running task_configure_nodewords task');
}

/**
 * Configures contact form
 */
function configure_contact() {
  $result = db_query("INSERT INTO {contact}
                      (category, recipients, selected)
                      VALUES ('%s', '%s', %d)",
                      'Website Administrator', 'njyoung+ncstateofficial_contact_form@ncsu.edu', 1);

  watchdog('ncstateofficial_profile', 'Configured contact form');
}

/**
 * Configures captcha and recaptcha
 */
function configure_captcha() {

  // Configure captcha/recaptcha settings
  variable_set('captcha_add_captcha_description', 0);
  variable_set('captcha_allow_on_admin_pages', 0);
  variable_set('captcha_default_challenge', 'recaptcha/reCAPTCHA');
  variable_set('captcha_default_validation', 1);
  variable_set('captcha_administration_mode', 0);
  variable_set('recaptcha_ajax_api', 1);
  variable_set('recaptcha_private_key', '6LdvWc0SAAAAAHytAais_ARotfgOpYx9320JSsrK');
  variable_set('recaptcha_public_key', '6LdvWc0SAAAAAJZF0eyUtotIiq9bBWFBh3CuJGgx');
  variable_set('recaptcha_theme', 'white');

  $types = array(
    array(
      'form_id' => 'comment_form',
      'captcha_type' => 'default',
    ),
    array(
      'form_id' => 'contact_mail_page',
      'captcha_type' => 'default',
    ),
    array(
      'form_id' => 'contact_mail_user',
      'captcha_type' => 'default',
    ),
  );

  // Clear everything from the table because i'm lazy and don't want to write any
  // SQL update scripts
  db_query("TRUNCATE TABLE {captcha_points}");
  foreach ($types as $type) {
    $result = db_query("INSERT INTO {captcha_points}
                        (form_id, captcha_type)
                        VALUES ('%s', '%s')",
                        $type['form_id'], $type['captcha_type']);
  };
  watchdog('ncstateofficial_profile', 'Configured captcha');
}

/**
 * Configures backup and migrate
 */
function configure_backup_migrate() {
  gen_backup_migrate_profile();
  gen_backup_migrate_destinations();
  gen_backup_migrate_schedules();
  watchdog('ncstateofficial_profile', 'Configured backup and migrate');
}

/**
 * Enables home page slider feature, generates the taxonomy term(s) required
 */
function enable_feature_ncstate_slider() {
    $enable_modules = array(
  		'ncstate_slider',
  	);
  	
  	module_enable($enable_modules);

  	watchdog('ncstateofficial_profile', 'Enabled home page slider feature');
};

/**
 * Configures home page slider
 */
function configure_feature_ncstate_slider() {
    
	/*
	 *  @todo change this to actually look up the correct value.
	 *  
	 *  Worked on this for a long time, but cannot get the query to work
	 *  because the feature schema (i think) isn't ready yet, so there's
	 *  no value in the DB when this runs.
	 *  
	 *  So for now...just manualy insert of the term with a parent id of 1
	 *  as it should be the only vocabulary
	 *  
	 *  This will break things though if another module/feature is added that
	 *  also create vocabularies before this is run
	 * 
	 */
	
	/*
	$name = 'Syndication';
	$limit = 1;
	$query = db_query("SELECT * FROM {vocabulary} WHERE name = '%s' LIMIT %d", $name, $limit);    
	while ($row = db_fetch_array($query)) { // this returns the row as an array, use db_fetch_object to get an object
	  $vid = $row['vid'];
	}
	*/
	
  	$term = array(
		'vid' => 1, // Vocabulary ID
		'name' => 'Home Page Slider', // Term Name
	);
	
	taxonomy_save_term($term);
          
	watchdog('ncstateofficial_profile', 'Configured home page slider feature');
	
};

function create_first_node() {

	$node = new StdClass();
	//creating a bare node
	
	$node->type = 'page';
	//giving it type
	
	$node->status = 1;
	//give it a published staus
	
	$node->title = "Welcome";
	//gives title
	
	$node->body = "This is a brand new website. An Administrator still needs to log in and update some content.";
	//gives body
	
	node_save($node);
	//save it and give it the rest of the attributes
	
	 variable_set('site_frontpage', 'node/1');	
  
  watchdog('ncstateofficial_profile', 'Added first node and set as home page');

}

function create_standard_menus() {
	
	// Building menus
  $menus = array(
    'Main-Menu' => array(
      'menu_name' => 'menu-main-menu',
      'title' => 'Main Menu',
      'description' => 'These links will appear where the main menu block is placed.'
    ),
  );

  foreach ($menus as $menu) {
    drupal_write_record('menu_custom', $menu);
  };
	
}

function create_standard_menu_links() {
	
	$links = array(
	    'front' => array(
	      'menu_name' => 'menu-main-menu',
	      'link_path' => '<front>',
	      'link_title' => 'Home',
	      'weight' => -50,
	    ),
	    'feedback' => array(
	      'menu_name' => 'menu-main-menu',
	      'link_path' => 'contact',
	      'link_title' => 'Contact Us',
	      'weight' => -49,
	    ),
	);

	foreach ($links as $link) {
		menu_link_save($link);
	}
	
}

function configure_blocks() {
	
	db_query("UPDATE {blocks} SET status = 0 where theme = '%s'", get_theme_name());
	
	$blocks = array(
	    'menu-main-menu' => array(
	      'module' => 'menu',
	      'delta' => 'menu-main-menu',
	      'theme' => get_theme_name(),
	      'status' => 1,
	      'region' => 'left_primary_menu',
	      'title' => '<none>',
	      'weight' => '-8',
	    ),
	    'search' => array(
	      'module' => 'search',
	      'delta' => '0',
	      'theme' => get_theme_name(),
	      'status' => 1,
	      'region' => 'header_search',
	      'title' => 'Search',
	      'weight' => '-10',
	    ),
	    'wraplogin_block' => array(
	      'module' => 'wraplogin',
	      'delta' => '0',
	      'theme' => get_theme_name(),
	      'status' => 1,
	      'region' => 'left_primary_menu',
	      'title' => '<none>',
	      'weight' => '-6',
	    ),
    );

  foreach ($blocks as $block) {
    // Inserts the block into the block menu
    drupal_write_record('blocks', $block);

  }
  watchdog('ncstateofficial_profile', 'Configured blocks');
  
}

function configure_gcal_events() {
	
	// get gcal_events directory
	$modulePath = drupal_get_path('module', 'gcal_events');	
	
	$simplePieLibraryPath = libraries_get_path('simplepie');
	
	// create cache directory in gcal_events directory, make writable by server
	mkdir($modulePath . '/cache', 0755, false);	
	
	// copy simplepie.inc from libraries directory to gcal_events directory
	copy($simplePieLibraryPath . '/simplepie.inc', $modulePath . '/simplepie.inc');
	
	watchdog('ncstateofficial_profile', 'Configured GCal Events Module');
	
	variable_set('gcal_events_num_blocks', 1);
	
	$delta = 0;
	$private_id = '927973de0296fbd3520681e5bd96f921';
	
	//variable_set('gcal_events_private_id_'. $delta, $private_id);
	variable_set('gcal_events_block_'. $delta, $delta);
	variable_set('gcal_events_admin_name_'. $delta, 'NC State Academic Calendar');
	variable_set('gcal_events_calendar_id_'. $delta, 'ncsu.edu_507c8794r25bnebhjrrh3i5c4s@group.calendar.google.com');
	variable_set('gcal_events_cache_duration_'. $delta, '3600');
	variable_set('gcal_events_num_events_'. $delta, '5');
	variable_set('gcal_events_dateformat_'. $delta, 'j F, Y');
	variable_set('gcal_events_timeformat_'. $delta, 'g:ia');
	variable_set('gcal_events_template_event_'. $delta, '<div class="gcal_block_event"><span class="element date">#DATE#</span><span class="element time">#TIME#</span><span class="element title">#TITLE#</span><span class="element location">#LOC#</span></div>');
	variable_set('gcal_events_template_title_'. $delta, '<a target="_blank" title="#TITLE#" href="#URL#">#TITLE#</a>');
	variable_set('gcal_events_template_desc_'. $delta, '#DESC#');
	variable_set('gcal_events_template_date_'. $delta, '#DATE#');
	variable_set('gcal_events_template_time_'. $delta, '#TIME#');
	variable_set('gcal_events_template_loc_'. $delta, '#LOC#');
	variable_set('gcal_events_empty_'. $delta, 'No events to display');
	variable_set('gcal_events_footer_'. $delta, '<a href="http://go.ncsu.edu/drupal-acad-calendar-more-link" target="_blank" title="Subscribe & view all events">Subscribe & view all events</a>');
	
	//configure first calendar block for gcal events to use NC State Academic Calendar
	$blocks = array(
	    'gcal_events_private_id_'. $delta => array(
	      	'module' 								=> 'gcal_events',
		    'delta' 								=> $delta,
		    'title' 								=> 'NC State Academic Calendar',
			'region' 								=> 'right_above_sidebar',
			'weight' 								=> '-6',
			'status' 								=> 1,
			'theme' 								=> get_theme_name(),
	    ),
    );

  foreach ($blocks as $block) {
    // Inserts the block into the block menu
    drupal_write_record('blocks', $block);

  }
  
	
  watchdog('ncstateofficial_profile', 'Configured GCal Events Academic Calendar Block');
	
}
