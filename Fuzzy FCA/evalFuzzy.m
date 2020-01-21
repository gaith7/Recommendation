
function val = evalFuzzy(Status, Promised_Availability, Actual_Availability, Outages)
    fis = readfis('project.fis')
    val = evalfis([Status;Promised_Availability;Actual_Availability;Outages], fis)
end