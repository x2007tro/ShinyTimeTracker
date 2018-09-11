# ShinyTimeTracker
Time tracking site for 1MSI time records

## Main functions
- Three tabs
	- Time Entry
		- Daily conf
		- Weekly conf
		- Entry
	- File Preview
		- Mapping table
		- Weekly final entry spreadsheet
	- Configuration

- Daily conf
	- Work date
	- Number of time entry slots
	- Auto-fill remaining untracked time (7.5 hours minus tracked)
	- Reset all entries
	
- Weekly conf
	- Generate final time entry spreadsheet using daily files (also activate preview)
		- [Pay Type]
		- [Pay Type Description] (Empty)
		- [Hours]
		- [Work Date]
		- [Account Number]
		- [Extended Description]
	- Email final time entry spreadsheet

- Time entry input with the following fields:
	- Work date (textInput, inherit from daily conf work date)
	- Client & Project (selectorInput)
	- Job (selectorInput)
	- Start time (auto-filled by start button)
	- End time (auto-filled by end button)
	- time duration (auto-filled when end button is clicked)
	- Narrative (textInput)
	- Start (button)
	- End (button)
	- Save (button) (save time records to a spreadsheet)
	- Message (textInput, for saving message)

- Configuration
	- Daily file location
	- Weekly file location
	- Mapping file location
	- Clear all daily files
	- Clear all weekly files
	- Add mapping record (Client&Project and job)
		- Client&Project Description/Number
		- Type Description/Number

## How it works
- Daily conf
	- One CSV file will be created for each 'Work Date'
	- Once 'Save' button is clicked, all records will be exported (overwrite) to this daily CSV file
	- Empty records will be recorded too, but they will be eliminated when converting to weekly file
- Auto-fill untracked time
	- One entry will be added to existing ones (empty and non-empty)
- Weekly conf
	- Row bind all daily files
	- Delete empty records (no account number)
	- Convert to final format
	- Save and generate preview
- Add mapping record
	- Append the record to existing mapping files
	
## Required Packages
- require(readxl)
- require(DT)
