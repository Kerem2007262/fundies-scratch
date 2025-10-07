use context dcic2024
include csv
include data-source

voter-data = load-table: VoterID,DOB,Party,Address,City,County,Postcode
    source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/voters.csv", default-options)
end

voter-data

filter-with(voter-data, lam(r): r["Party"] == "Labour" end).length()

fun blank-to-undecided(s :: String) -> String:
  doc: "replaces an empty string with Undecided"
  if s == "":
    "Undecided"
  else:
    s
  end
where:
  blank-to-undecided("") is "Undecided"
  blank-to-undecided("blah") is "blah"
end

undecided-voters = transform-column(voter-data, "Party", blank-to-undecided)

freq-bar-chart(undecided-voters, "Party")