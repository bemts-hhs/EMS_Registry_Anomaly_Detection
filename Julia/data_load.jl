###_____________________________________________________________________________
# Load data for the anomaly detection project using .env vars
###_____________________________________________________________________________

# Simple validation for missing paths
required_paths = iowa_ems_registry_counts_path;

	if isempty(required_paths)
		@warn "Path for $required_paths is empty. Update .env before attempting to load data."
    else 
        @info "Path for $required_paths is valid."
	end;

# Load all project data for anomaly detection via environment variable paths
ems_registry_counts_file = DataFrames.DataFrame(
	XLSX.readtable(
		iowa_ems_registry_counts_path, "count_of_distinct_incident_numb"
		)
	);

# Use @glimpse() macro to examine each dataframe.
@glimpse(ems_registry_counts_file)

# clean names
ems_registry_counts = @chain ems_registry_counts_file begin
    @rename_with col -> str_remove_all(col, r"\s*\(.+\)$")
    @clean_names()
    @mutate(
        agency_number = ifelse(
            ismissing(agency_number), 1234567, agency_number
        ),
        across(`2020`:`2026`, x -> coalesce.(x, 0)),
        count_of_distinct_incident_numbers_grand_total = coalesce(count_of_distinct_incident_numbers_grand_total, 0)
    )
    @select -(`2020`:`2026`)
    @rename_with col -> str_remove_all(col, r"_function$")
    @relocate(starts_with("count_of_distinct"), after = `2026`)
end;

# Use @glimpse() macro again to examine each dataframe.
@glimpse(ems_registry_counts)
