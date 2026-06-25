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
ems_registry_counts = XLSX.readxlsx(iowa_ems_registry_counts_path);

# Use @glimpse() macro to examine each dataframe.
