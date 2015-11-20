As a practice Rails project, I wrote this CRUD app in late 2013 to collect data in a diabetes clinical study for later analysis. (The app ended up not being used in production because Google Sheets provided a sufficient solution for the Waivers-grant study.)

I revised the project in late 2015, fleshing out the functionality and cleaning up the styling. It's functional and coherent, if not nice:
*   The display of patient records (https://aqueous-garden-9507.herokuapp.com/patients/1/records) mimicks the paper records in use by the team conducting the study:
    *   Records are displayed in a horizontal table, where each row displays records of a given type.
    *   Within each row, records are sorted oldest on the left to newest on the right.
    *   Within each row, the list of records grows to the right and defaults to showing the right-most (newest) records.
*   Ajax links avoid superfluous queries.
    * I used the gem unobtrusive flash to make the flash play nicely with ajax. I ended up patching the gem and submitted this pull-request: https://github.com/leonid-shevtsov/unobtrusive_flash/pull/29
*   At any patient visit, it is likely that there will be new data for only some sets of lab values and/or measurements. Therefore, the form for a new "patient record" (https://aqueous-garden-9507.herokuapp.com/patients/1/records) does not require all types of data but accepts any valid subset of data. The Record form-object delegtes to the appropriate models.

Live demo: https://aqueous-garden-9507.herokuapp.com/
