/*

  https://github.com/WhyAskWhy/automated-tickets-dev

  Purpose:

      Import test Automated Ticket entries data for development purposes

  Notes:

    * If 0 is used for redmine_new_issue_due_after_days, then the due date
      is set for the same day, otherwise it is generated as ticket
      creation date + the number of days specified

    * We do not specify a the from/to column values; the read query
      will use a default value for each from the config file

    * We are relying on each task to default to enabled

    * Tasks are not "intern" tasks by default

    * Priority is set to 'Normal' by default

*/

-- Variables, because I'm feeling lazy
SET @ds_project = 'desktop-support';
SET @ss_project = 'server-support';
SET @home_project = 'home';

SET @ds_email = 'automated-reminders@example.com';
SET @ss_email = 'automated-reminders@example.com';
SET @home_email = 'automated-reminders@example.com';


-- Here we are inserting a row with the redmine_new_issue_due_after_days
-- value set to 0. This results in the read query subsituting that value
-- for the current date so that tickets have the due date set to the
-- same day the ticket was generated. We are also overriding the default
-- priority.
INSERT INTO `event_reminders`.`events`
  (
    `intern_task`,
    `email_from_address`,
    `email_subject_prefix`,
    `redmine_wiki_page_name`,
    `redmine_wiki_page_project_shortname`,
    `redmine_new_issue_project`,
    `redmine_new_issue_category`,
    `redmine_new_issue_due_after_days`,
    `redmine_new_issue_priority`,
    `event_schedule`,
    `comments`
  )
VALUES

    (1,@ds_email,'Pickup/Deliver mail for {}','AutomatedTicketsMailCheck','docs',@ds_project,'Checks - Email',0,'Normal','daily','no particular priority'),

    (1,@ds_email,'Cleanup work areas for {}','AutomatedTicketsWorkAreaCleanup','docs',@ds_project,'Cleanup/Sort',0,'Normal','twice_week','no particular priority'),

    (1,@ds_email,'Check storage supplies for {}','AutomatedTicketsCheckStorageSupplies','docs',@ds_project,'Checks - Storage',0,'Normal','weekly','no particular priority'),

    (1,@ds_email,'Verify dry-erase department calendar for {}','AutomatedTicketsSystemsDryEraseCalendar','docs',@ds_project,'Cleanup/Sort',7,'Normal','monthly','Historically no due date'),

    (1,@ds_email,'Process paper shred box for {}','AutomatedTicketsShredPaper','docs',@ds_project,'Cleanup/Sort',7,'Normal','twice_week','Probably needs to be 2x week'),

    (0,@ss_email,'mssql.example.com - Microsoft Updates for {}','AutomatedTicketsManualPatching','docs',@ss_project,'Patch',21,'High','monthly','Historically no due date, normal priority'),

    (0,@ss_email,'storageserver1.example.com - Microsoft Updates for {}','AutomatedTicketsManualPatching','docs',@ss_project,'Patch',21,'High','monthly','Historically no due date, normal priority'),

    (0,@ss_email,'loanserver.example.com - Microsoft Updates for {}','AutomatedTicketsManualPatching','docs',@ss_project,'Patch',21,'High','monthly','Historically no due date, normal priority'),

    (0, @home_email, 'Replace toothbrushes for {}', 'AutomatedTicketsReplaceToothbrushes', 'docs', @home_project, 'Bathroom', 1, 'Normal', 'quarterly', NULL),

    (0, @home_email, 'Check tire pressure on vehicles for {}', 'AutomatedTicketsVehiclesCheckTirePressure', 'docs', @home_project, 'Vehicles', 1, 'Normal', 'monthly', NULL),

    (0, @home_email, 'Clean windows in vehicles for {}', 'AutomatedTicketsVehiclesCleanWindows', 'docs', @home_project, 'Vehicles', 1, 'Normal', 'monthly', NULL),

    (0, @home_email, 'Replace sinus rinse bottles for {}', 'AutomatedTicketsReplaceSinusRinseBottles', 'docs', @home_project, 'Bathroom', 1, 'Normal', 'quarterly', NULL),

    (0, @home_email, 'Replace sink water filter for {}', 'AutomatedTicketsReplaceSinkWaterFilter', 'docs', @home_project, 'Kitchen', 1, 'Normal', 'monthly', 'This is an example of a task that needs to be repeated every 6 weeks, but is not yet supported.'),

    (0, @home_email, 'Check cat food feeder for {}', 'AutomatedTicketsCheckCatFoodFeeder', 'docs', @home_project, 'Pets', 1, 'Normal', 'twice_week', NULL),

    (0, @home_email, 'Feed cats wet food + medicine for {}', 'AutomatedTicketsFeedCatsWetFood', 'docs', @home_project, 'Pets', 0, 'Normal', 'weekly_sunday', NULL),

    (0, @home_email, 'Swap water bowl for {}', 'AutomatedTicketsChangeCatWater', 'docs', @home_project, 'Pets', 1, 'Normal', 'weekly_sunday', NULL),

    (0, @home_email, 'Wash kids bedroom sheets for {}', 'AutomatedTicketsWashKidsBedclothes', 'docs', @home_project, 'Bedroom', 1, 'Normal', 'twice_month', NULL),

    (0, @home_email, 'Clean back porch for {}', 'AutomatedTicketsCleanPorches', 'docs', @home_project, 'Yard', 1, 'Normal', 'monthly', NULL),

    (0, @home_email, 'Central air filter: clean or replace for {}', 'AutomatedTicketsAirFilterMaintenanceCentral', 'docs', @home_project, 'Air Filter', 1, 'High', 'monthly', NULL),

    (0, @home_email, 'Master bedroom air filter: clean or replace for {}', 'AutomatedTicketsAirFilterMaintenanceMasterBedroom', 'docs', @home_project, 'Air Filter', 1, 'High', 'monthly', NULL),

    (0, @home_email, 'Kids Bedroom air filter: clean or replace for {}', 'AutomatedTicketsAirFilterMaintenanceKidsBedroom', 'docs', @home_project, 'Air Filter', 1, 'High', 'monthly', NULL),

    (0, @home_email, 'Living room air filter: clean or replace for {}', 'AutomatedTicketsAirFilterMaintenanceLivingRoom', 'docs', @home_project, 'Air Filter', 1, 'High', 'monthly', NULL),

    (0, @home_email, 'Add tablets to AC try for {}', 'AutomatedTicketsAddTabletsToCentralAirTray', 'docs', @home_project, 'Air Filter', 1, 'Normal', 'monthly', NULL),

    (0, @home_email, 'Office air filter: clean or replace for {}', 'AutomatedTicketsAirFilterMaintenanceOffice', 'docs', @home_project, 'Air Filter', 1, 'Normal', 'monthly', NULL),

    (0, @home_email, 'Change litter pan for {}', 'AutomatedTicketsAirFilterMaintenanceOffice', 'docs', @home_project, 'Pets', 1, 'Normal', 'twice_week', NULL),

    (0, @home_email, 'Clean gutters for {}', 'AutomatedTicketsCleanGutters', 'docs', @home_project, 'Yard', 1, 'Normal', 'quarterly', NULL),

    (0, @home_email, 'Pay water bill for {}', 'AutomatedTicketsPayBillWater', 'docs', @home_project, 'Fees', 9, 'High', 'monthly', 'This is an example of a task that has a set, very specific (billing) due date'),

    (0, @home_email, 'Pay van note for {}', 'AutomatedTicketsPayBillVehicle', 'docs', @home_project, 'Fees', 4, 'High', 'monthly', 'This is an example of a task that has a set, very specific (billing) due date'),

    (0, @home_email, 'Inventory cat supplies for {}', 'AutomatedTicketsInventoryCatSupplies', 'docs', @home_project, 'Pets', 1, 'Normal', 'weekly', NULL),

    (0, @home_email, 'Check work supplies for {}', 'AutomatedTicketsCheckWorkSupplies', 'docs', @home_project, 'Purchasing', 0, 'Normal', 'weekly_friday', NULL),

    (0, @home_email, 'Clean fan in master bathroom for {}', 'AutomatedTicketsCleanBathroomFan', 'docs', @home_project, 'Cleaning', 0, 'Normal', 'monthly', NULL),

    (0, @home_email, 'Pack lunchbox with refills for work ({})', 'AutomatedTicketsPackLunchBoxWithRefills', 'docs', @home_project, 'Purchasing', 0, 'Normal', 'weekly_sunday', NULL),

    (0, @home_email, 'Clean fridge coils for {}', 'AutomatedTicketsCleanFridgeCoils', 'docs', @home_project, 'Cleaning', 1, 'Normal', 'monthly', 'Changed from weekly to monthly.'),

    (0, @home_email, 'Clean fridge shelves for {}', 'AutomatedTicketsCleanFridgeShelves', 'docs', @home_project, 'Cleaning', 1, 'Normal', 'weekly_sunday', NULL),

    (0, @home_email, 'Vacuum vehicles for {}', 'AutomatedTicketsVacuumVehicles', 'docs', @home_project, 'Vehicles', 1, 'Normal', 'monthly', NULL),

    (0, @home_email, 'Replace CPAP air filter for {}', 'AutomatedTicketsAirFilterCPAP', 'docs', @home_project, 'Air Filter', 1, 'Normal', 'monthly', NULL)

;
