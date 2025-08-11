# BDDK API R Function
# Required libraries will be called with package::function notation

fetch_data <- function(start_year,
                       start_month,
                       end_year,
                       end_month,
                       table_no,
                       currency,
                       group,
                       lang = "tr",
                       save_excel = FALSE) {

  #' Fetches data from the BDDK API
  #'
  #' @param start_year integer: Starting year (YYYY format)
  #' @param start_month integer: Starting month (1-12)
  #' @param end_year integer: Ending year (YYYY format)
  #' @param end_month integer: Ending month (1-12)
  #' @param table_no integer: Table number (e.g., 1)
  #' @param currency character: Currency type (e.g., "TL", "USD")
  #' @param group integer: Group type (e.g., 10001)
  #' @param lang character: Language selection, default 'tr'
  #' @param save_excel logical: If TRUE, saves data to Excel. Default is FALSE.
  #'
  #' @return data.frame: Returns data as a data.frame. Returns NULL if no data is available.

  # Configuration data
  bddk_config <- list(
    translations = list(
      unsupported_language = list(
        tr = "Unsupported language: %s. Supported languages: %s",
        en = "Unsupported language: %s. Supported languages: %s"
      ),
      invalid_type = list(
        tr = "Parameter %s invalid type. Expected: %s, Got: %s",
        en = "Parameter %s invalid type. Expected: %s, Got: %s"
      ),
      invalid_month_range = list(
        tr = "Parameter %s invalid value: %s. Must be between 1-12",
        en = "Parameter %s invalid value: %s. Must be between 1-12"
      ),
      config_not_found = list(
        tr = "Configuration not found",
        en = "Configuration not found"
      ),
      unsupported_currency = list(
        tr = "Unsupported currency: %s",
        en = "Unsupported currency: %s"
      ),
      invalid_date_range = list(
        tr = "Invalid date range",
        en = "Invalid date range"
      ),
      no_data_found = list(
        tr = "No data found for %d-%d",
        en = "No data found for %d-%d"
      ),
      fetch_error = list(
        tr = "Data fetch error: %s",
        en = "Data fetch error: %s"
      ),
      json_key_error = list(
        tr = "JSON key error: %s (%d-%d)",
        en = "JSON key error: %s (%d-%d)"
      ),
      warning_no_data_range = list(
        tr = "No data found in the specified date range",
        en = "No data found in the specified date range"
      )
    ),
    tables = list(
      "1" = list(
        selected_columns = 1:10,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Total Assets", en = "Total Assets"),
          list(tr = "Loans", en = "Loans"),
          list(tr = "Securities", en = "Securities"),
          list(tr = "Total Liabilities", en = "Total Liabilities"),
          list(tr = "Deposits", en = "Deposits"),
          list(tr = "Equity", en = "Equity"),
          list(tr = "Off Balance Sheet", en = "Off Balance Sheet"),
          list(tr = "Other", en = "Other")
        ),
        table_name = list(tr = "Balance Sheet", en = "Balance Sheet")
      ),
      "2" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Interest Income", en = "Interest Income"),
          list(tr = "Interest Expenses", en = "Interest Expenses"),
          list(tr = "Net Interest Income", en = "Net Interest Income"),
          list(tr = "Non-Interest Income", en = "Non-Interest Income"),
          list(tr = "Operating Expenses", en = "Operating Expenses"),
          list(tr = "Net Profit/Loss", en = "Net Profit/Loss")
        ),
        table_name = list(tr = "Income Statement", en = "Income Statement")
      ),
      "3" = list(
        selected_columns = 1:10,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Cash Loans", en = "Cash Loans"),
          list(tr = "Non-Cash Loans", en = "Non-Cash Loans"),
          list(tr = "Total Loans", en = "Total Loans"),
          list(tr = "NPL", en = "NPL"),
          list(tr = "Specific Provisions", en = "Specific Provisions"),
          list(tr = "Net Loans", en = "Net Loans"),
          list(tr = "Loan/Asset Ratio", en = "Loan/Asset Ratio"),
          list(tr = "NPL Ratio", en = "NPL Ratio")
        ),
        table_name = list(tr = "Loans", en = "Loans")
      ),
      "4" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Standard", en = "Standard"),
          list(tr = "Close Monitoring", en = "Close Monitoring"),
          list(tr = "Substandard", en = "Substandard"),
          list(tr = "Doubtful", en = "Doubtful"),
          list(tr = "Loss", en = "Loss"),
          list(tr = "Total", en = "Total")
        ),
        table_name = list(tr = "Consumer Loans", en = "Consumer Loans")
      ),
      "5" = list(
        selected_columns = 1:10,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Agriculture", en = "Agriculture"),
          list(tr = "Manufacturing", en = "Manufacturing"),
          list(tr = "Construction", en = "Construction"),
          list(tr = "Trade", en = "Trade"),
          list(tr = "Transportation", en = "Transportation"),
          list(tr = "Tourism", en = "Tourism"),
          list(tr = "Other", en = "Other"),
          list(tr = "Total", en = "Total")
        ),
        table_name = list(tr = "Sectoral Credit Distribution", en = "Sectoral Credit Distribution")
      ),
      "6" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "SME Loans", en = "SME Loans"),
          list(tr = "SME NPL", en = "SME NPL"),
          list(tr = "SME NPL Ratio", en = "SME NPL Ratio"),
          list(tr = "SME Provisions", en = "SME Provisions"),
          list(tr = "Net SME", en = "Net SME"),
          list(tr = "SME/Total", en = "SME/Total")
        ),
        table_name = list(tr = "SME Loans", en = "SME Loans")
      ),
      "7" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Syndication Loans", en = "Syndication Loans"),
          list(tr = "International", en = "International"),
          list(tr = "Domestic", en = "Domestic"),
          list(tr = "TL", en = "TL"),
          list(tr = "FX", en = "FX"),
          list(tr = "Total", en = "Total")
        ),
        table_name = list(tr = "Syndication Securitization Loans", en = "Syndication Securitization Loans")
      ),
      "8" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Government Bonds", en = "Government Bonds"),
          list(tr = "Treasury Bills", en = "Treasury Bills"),
          list(tr = "Private Sector", en = "Private Sector"),
          list(tr = "Stocks", en = "Stocks"),
          list(tr = "Other", en = "Other"),
          list(tr = "Total", en = "Total")
        ),
        table_name = list(tr = "Securities", en = "Securities")
      ),
      "9" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Demand TL", en = "Demand TL"),
          list(tr = "Time TL", en = "Time TL"),
          list(tr = "Demand FX", en = "Demand FX"),
          list(tr = "Time FX", en = "Time FX"),
          list(tr = "Total TL", en = "Total TL"),
          list(tr = "Total FX", en = "Total FX")
        ),
        table_name = list(tr = "Deposits by Types", en = "Deposits by Types")
      ),
      "10" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "1 Month", en = "1 Month"),
          list(tr = "3 Months", en = "3 Months"),
          list(tr = "6 Months", en = "6 Months"),
          list(tr = "1 Year", en = "1 Year"),
          list(tr = "Over 1 Year", en = "Over 1 Year"),
          list(tr = "Total", en = "Total")
        ),
        table_name = list(tr = "Deposits by Maturity", en = "Deposits by Maturity")
      ),
      "11" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Cash", en = "Cash"),
          list(tr = "CBRT", en = "CBRT"),
          list(tr = "Banks", en = "Banks"),
          list(tr = "Loans", en = "Loans"),
          list(tr = "Securities", en = "Securities"),
          list(tr = "Liquidity Ratio", en = "Liquidity Ratio")
        ),
        table_name = list(tr = "Liquidity Status", en = "Liquidity Status")
      ),
      "12" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Capital", en = "Capital"),
          list(tr = "Reserves", en = "Reserves"),
          list(tr = "Profit", en = "Profit"),
          list(tr = "Total Equity", en = "Total Equity"),
          list(tr = "CAR", en = "CAR"),
          list(tr = "Tier 1", en = "Tier 1")
        ),
        table_name = list(tr = "Capital Adequacy", en = "Capital Adequacy")
      ),
      "13" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "USD Assets", en = "USD Assets"),
          list(tr = "USD Liabilities", en = "USD Liabilities"),
          list(tr = "EUR Assets", en = "EUR Assets"),
          list(tr = "EUR Liabilities", en = "EUR Liabilities"),
          list(tr = "Net USD", en = "Net USD"),
          list(tr = "Net EUR", en = "Net EUR")
        ),
        table_name = list(tr = "Foreign Exchange Position", en = "Foreign Exchange Position")
      ),
      "14" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Guarantees", en = "Guarantees"),
          list(tr = "Letters of Credit", en = "Letters of Credit"),
          list(tr = "Acceptance Credits", en = "Acceptance Credits"),
          list(tr = "Derivatives", en = "Derivatives"),
          list(tr = "Other", en = "Other"),
          list(tr = "Total", en = "Total")
        ),
        table_name = list(tr = "Off-Balance Sheet Items", en = "Off-Balance Sheet Items")
      ),
      "15" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "ROA", en = "ROA"),
          list(tr = "ROE", en = "ROE"),
          list(tr = "Net Interest Margin", en = "Net Interest Margin"),
          list(tr = "Non-Interest/Total", en = "Non-Interest/Total"),
          list(tr = "Cost/Income", en = "Cost/Income"),
          list(tr = "Efficiency", en = "Efficiency")
        ),
        table_name = list(tr = "Ratios", en = "Ratios")
      ),
      "16" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Branch Count", en = "Branch Count"),
          list(tr = "ATM Count", en = "ATM Count"),
          list(tr = "POS Count", en = "POS Count"),
          list(tr = "Personnel", en = "Personnel"),
          list(tr = "Assets/Branch", en = "Assets/Branch"),
          list(tr = "Assets/Personnel", en = "Assets/Personnel")
        ),
        table_name = list(tr = "Other Information", en = "Other Information")
      ),
      "17" = list(
        selected_columns = 1:8,
        column_names = list(
          list(tr = "Bank Code", en = "Bank Code"),
          list(tr = "Bank Name", en = "Bank Name"),
          list(tr = "Istanbul", en = "Istanbul"),
          list(tr = "Ankara", en = "Ankara"),
          list(tr = "Izmir", en = "Izmir"),
          list(tr = "Other Cities", en = "Other Cities"),
          list(tr = "International", en = "International"),
          list(tr = "Total", en = "Total")
        ),
        table_name = list(tr = "International Branch Ratios", en = "International Branch Ratios")
      )
    ),
    groups = list(
      "10001" = "Deposit Banks",
      "10002" = "Development and Investment Banks",
      "10003" = "Participation Banks",
      "10004" = "All Banks",
      "20001" = "State Banks",
      "20002" = "Private Banks",
      "20003" = "Foreign Banks",
      "30001" = "Large Scale Banks",
      "30002" = "Medium Scale Banks",
      "30003" = "Small Scale Banks"
    )
  )

  tryCatch({
    # Language validation
    supported_languages <- c("tr", "en")
    if (!lang %in% supported_languages) {
      tr_message <- sprintf(bddk_config$translations$unsupported_language$tr,
                            lang, paste(supported_languages, collapse = ", "))
      en_message <- sprintf(bddk_config$translations$unsupported_language$en,
                            lang, paste(supported_languages, collapse = ", "))
      stop(paste(tr_message, en_message, sep = "\n"))
    }

    # Type validation
    if (!is.numeric(start_year) || start_year != as.integer(start_year)) {
      stop(sprintf(bddk_config$translations$invalid_type[[lang]], "start_year", "integer", class(start_year)))
    }
    if (!is.numeric(start_month) || start_month != as.integer(start_month) ||
        start_month < 1 || start_month > 12) {
      stop(sprintf(bddk_config$translations$invalid_month_range[[lang]], "start_month", start_month))
    }
    if (!is.numeric(end_year) || end_year != as.integer(end_year)) {
      stop(sprintf(bddk_config$translations$invalid_type[[lang]], "end_year", "integer", class(end_year)))
    }
    if (!is.numeric(end_month) || end_month != as.integer(end_month) ||
        end_month < 1 || end_month > 12) {
      stop(sprintf(bddk_config$translations$invalid_month_range[[lang]], "end_month", end_month))
    }
    if (!is.numeric(table_no) || table_no != as.integer(table_no)) {
      stop(sprintf(bddk_config$translations$invalid_type[[lang]], "table_no", "integer", class(table_no)))
    }
    if (!is.character(currency)) {
      stop(sprintf(bddk_config$translations$invalid_type[[lang]], "currency", "character", class(currency)))
    }
    if (!is.numeric(group) || group != as.integer(group)) {
      stop(sprintf(bddk_config$translations$invalid_type[[lang]], "group", "integer", class(group)))
    }
    if (!is.character(lang)) {
      stop(sprintf(bddk_config$translations$invalid_type[[lang]], "lang", "character", class(lang)))
    }

    table_no_str <- as.character(table_no)
    group_str <- as.character(group)

    # Table validation
    valid_tables <- names(bddk_config$tables)
    if (!table_no_str %in% valid_tables) {
      stop(sprintf("%s: %s. Valid range is %s-%s.",
                   bddk_config$translations$config_not_found[[lang]],
                   table_no, min(valid_tables), max(valid_tables)))
    }

    # Group validation
    valid_groups <- names(bddk_config$groups)
    if (!group_str %in% valid_groups) {
      stop(sprintf("%s: %s. Please provide a valid group from %s.",
                   bddk_config$translations$config_not_found[[lang]],
                   group, paste(valid_groups, collapse = ", ")))
    }

    # Currency validation
    supported_currencies <- c("TL", "USD")
    if (!currency %in% supported_currencies) {
      message <- sprintf(bddk_config$translations$unsupported_currency[[lang]], currency)
      stop(message)
    }

    base_url <- sprintf("https://www.bddk.org.tr/BultenAylik/%s/Home/BasitRaporGetir", lang)

    # Date range validation
    if (start_year > end_year || (start_year == end_year && start_month > end_month)) {
      stop(bddk_config$translations$invalid_date_range[[lang]])
    }

    aggregated_dataframes <- list()
    start_date <- as.Date(sprintf("%d-%02d-01", start_year, start_month))
    end_date <- as.Date(sprintf("%d-%02d-01", end_year, end_month))
    current_date <- start_date

    while (current_date <= end_date) {
      year <- lubridate::year(current_date)
      month <- lubridate::month(current_date)

      payload <- list(
        tabloNo = table_no_str,
        yil = year,
        ay = month,
        paraBirimi = currency,
        taraf = group_str
      )

      headers <- c(
        "Content-Type" = "application/x-www-form-urlencoded; charset=UTF-8",
        "Accept" = "application/json, text/javascript, */*; q=0.01",
        "User-Agent" = "Mozilla/5.0",
        "Referer" = sprintf("https://www.bddk.org.tr/BultenAylik/%s/", lang),
        "Origin" = "https://www.bddk.org.tr"
      )

      tryCatch({
        cat(sprintf("Fetching data: %d-%02d\n", year, month))

        response <- httr::POST(base_url,
                               body = payload,
                               httr::add_headers(.headers = headers),
                               encode = "form",
                               httr::timeout(30))

        if (httr::status_code(response) != 200) {
          cat(sprintf("HTTP Error: %d (%d-%02d)\n", httr::status_code(response), year, month))
          next
        }

        response_content <- httr::content(response, "text", encoding = "UTF-8")
        response_json <- jsonlite::fromJSON(response_content, simplifyVector = FALSE)

        # JSON structure validation (updated according to debug output)
        if (is.null(response_json) ||
            !response_json$success ||
            is.null(response_json$Json) ||
            is.null(response_json$Json$data) ||
            is.null(response_json$Json$data$rows)) {
          cat(sprintf(bddk_config$translations$no_data_found[[lang]], year, month), "\n")
          next
        }

        data_rows <- response_json$Json$data$rows
        if (length(data_rows) == 0) {
          cat(sprintf(bddk_config$translations$no_data_found[[lang]], year, month), "\n")
          next
        }

        # Convert data to data.frame
        cell_data <- list()
        for (i in seq_along(data_rows)) {
          if (is.list(data_rows[[i]]) && "cell" %in% names(data_rows[[i]])) {
            cell_data[[i]] <- data_rows[[i]]$cell
          }
        }

        if (length(cell_data) == 0) {
          cat(sprintf("Data format doesn't match expected format (%d-%02d)\n", year, month))
          next
        }

        # Find the maximum vector length
        max_length <- max(sapply(cell_data, length))

        # Make all vectors the same length
        cell_data <- lapply(cell_data, function(x) {
          length(x) <- max_length
          return(x)
        })

        raw_dataframe <- as.data.frame(do.call(rbind, cell_data), stringsAsFactors = FALSE)

        # Use column names from API
        column_names <- NULL

        # Extract column names from colNames (structure seen in debug)
        if (!is.null(response_json$Json$colNames)) {
          api_column_names <- response_json$Json$colNames
          cat(sprintf("API colNames received (%d-%02d): %s\n",
                      year, month, paste(api_column_names, collapse = " | ")))

          # Replace empty names with meaningful names
          cleaned_names <- api_column_names
          for (i in seq_along(cleaned_names)) {
            if (is.na(cleaned_names[i]) || cleaned_names[i] == "" || cleaned_names[i] == " ") {
              if (i == 1) {
                cleaned_names[i] <- "Skip_Column"  # This column will be removed
              } else if (i == 2) {
                cleaned_names[i] <- "Order"
              } else if (i == 3) {
                cleaned_names[i] <- "Sector"  # "Sector" instead of "Description"
              } else {
                cleaned_names[i] <- paste0("Column_", i)
              }
            }
          }
          column_names <- cleaned_names
        } else {
          # Fallback: default names
          column_names <- paste0("Column_", 1:ncol(raw_dataframe))
        }

        # Align column count
        if (length(column_names) > ncol(raw_dataframe)) {
          column_names <- column_names[1:ncol(raw_dataframe)]
        } else if (length(column_names) < ncol(raw_dataframe)) {
          # Add names for missing columns
          missing_count <- ncol(raw_dataframe) - length(column_names)
          column_names <- c(column_names, paste0("Column_", (length(column_names) + 1):(length(column_names) + missing_count)))
        }

        names(raw_dataframe) <- column_names

        # Remove first column (Skip_Column)
        if ("Skip_Column" %in% names(raw_dataframe)) {
          raw_dataframe <- raw_dataframe[, !names(raw_dataframe) %in% "Skip_Column", drop = FALSE]
          cat(sprintf("First column removed (%d-%02d)\n", year, month))
        }

        cat(sprintf("Final column names (%d-%02d): %s\n",
                    year, month, paste(names(raw_dataframe), collapse = " | ")))

        table_config <- bddk_config$tables[[table_no_str]]
        if (!is.null(table_config)) {
          table_name <- table_config$table_name[[lang]]

          # Use all columns (with API-provided names)
          processed_dataframe <- raw_dataframe
          processed_dataframe$Period <- sprintf("%d-%02d-01", year, month)
          processed_dataframe$Table <- table_name
          aggregated_dataframes[[length(aggregated_dataframes) + 1]] <- processed_dataframe

          cat(sprintf("Data successfully retrieved: %d-%02d (%d rows, %d columns)\n",
                      year, month, nrow(processed_dataframe), ncol(processed_dataframe)))
        } else {
          stop(bddk_config$translations$config_not_found[[lang]])
        }

      }, error = function(e) {
        cat(sprintf("Error (%d-%02d): %s\n", year, month, e$message))
      })

      # Move to next month
      if (month == 12) {
        current_date <- as.Date(sprintf("%d-01-01", year + 1))
      } else {
        current_date <- as.Date(sprintf("%d-%02d-01", year, month + 1))
      }
    }

    if (length(aggregated_dataframes) > 0) {
      final_df <- do.call(rbind, aggregated_dataframes)
      rownames(final_df) <- NULL

      if (save_excel) {
        filename <- sprintf("bddk_%d_%02d_%d_%02d.xlsx",
                            start_year, start_month, end_year, end_month)
        tryCatch({
          writexl::write_xlsx(final_df, filename)
          cat(sprintf("Excel file saved: %s\n", filename))
        }, error = function(ex) {
          cat(sprintf("Excel file could not be saved: %s\n", ex$message))
        })
      }

      cat(sprintf("Returning %d rows of data\n", nrow(final_df)))
      colnames(final_df)[3] <- "Sektor"
      final_df <- dplyr::as_tibble(final_df[,-c(1,4)])
      return(final_df)
    } else {
      stop(bddk_config$translations$warning_no_data_range[[lang]])
    }

  }, error = function(e) {
    cat("ERROR:", e$message, "\n")
    return(NULL)
  })
}

# Usage example:
# data <- fetch_data(
#   start_year = 2023,
#   start_month = 1,
#   end_year = 2023,
#   end_month = 2,
#   table_no = 1,
#   currency = "TL",
#   group = 10001,
#   lang = "tr",
#   save_excel = FALSE
# )
