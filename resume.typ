#import "@preview/modern-cv:0.4.0": *

#show: resume.with(
  author: (
    firstname: "Mathieu",
    lastname: "Besançon",
    email: "first.lastname@biglab.fr",
    phone: "(+33) 111-111-1111",
    github: "matbesancon",
    linkedin: "corporate",
    address: "The Big Lab, 3rd Main Street, UniversityCity, France",
    positions: (
      "Inria Associate Researcher",
      "Mathematical Optimization",
    ),
  ),
  // date: datetime.today().display(),
  language: "en",
  colored-headers: true,
)

= Experience

#let expdata = toml("experience.toml")

// only show full time positions
#for entry in expdata.values().filter(e => e.fulltime ) [
  #resume-entry(
    title: entry.title,
    description: entry.institution,
    date: entry.date,
    location: entry.location,
  )
  #entry.description
]

= Education

#let educationdata = toml("education.toml")

#for entry in educationdata.values() [
  #resume-entry(
    title: entry.title,
    location: entry.institution,
    date: entry.date,
    description: entry.program,
  )
  #if ("description" in entry) {
    entry.description
  }
]

// This key defines the publication format between:
// A single file highlighted.bib with everything in it included OR
// Subsections from three bib files (submitted, journals, conferences)
#let selectedpubsonly = false

// Used to highlight your name in publications, you may have to adapt it to different citation styles
#show regex("Besançon, M\\.?"): name => text(navy, (strong(name)))

#if selectedpubsonly {
let bibdata = bibliography("publications/highlight.bib", full: true, title: "Selected Publications")
bibdata
 } else {
  show bibliography: none
  [= Publications]
  // Define which sections to include
  let sections = (
    ("Technical Reports and Working Papers", "submitted"),
    ("Journal Articles", "journals"),
    ("Conference Papers", "conferences"),
  )
  bibliography(sections.map(p => "publications/" + p.at(1) + ".yaml"), full: false)
  for (sectitle, filename) in sections {
    [== #sectitle]
    linebreak()
    let entries = yaml("publications/" + filename + ".yaml").pairs().sorted(key: p => p.at(1).date).rev().map(p => label(p.at(0)))
    for key in entries [
      #cite(key, form: "full", style: "american-physics-society")
      
    ]
    linebreak()
  }

 }


= Supervision

#let supervisiondata = toml("supervision.toml")

== Ph.D. Candidates

#for entry in supervisiondata.phd {
  [- #entry.firstname #entry.lastname, #entry.institution. #(entry.startmonth).#entry.startyear - #if entry.keys().contains("endmonth") {((entry.endmonth).entry.endyear )} else {"today"}. #if entry.keys().contains("coadvisor") [With #entry.coadvisor.] else []
  
  ]
}

== Recent Master's Theses

#for entry in supervisiondata.masters {
  [- #entry.firstname #entry.lastname, #entry.program at #entry.institution, #entry.topic #(entry.startmonth).#entry.startyear - #entry.endmonth.#entry.endyear. #if entry.keys().contains("coadvisor") [With #entry.coadvisor.] else []

  ]
}

= Recent and Selected Talks

#let parse(month, year) = toml.decode("date = '01-" + str(month) + " " + str(year) + "'").date

// Current logic for the talk filters: only show the ones that are less than a year old or that have the highlighted key
#let talkdata = toml("talks.toml")
#let filteredtalkdata = talkdata.values().filter(
  p =>
  p.at("highlight", default: false) or
  (datetime(day: 1, year: p.year, month: p.month) > datetime.today() - duration(days: 365) )
)


#resume-item[
#for entry in filteredtalkdata [
  #let typestring = text(entry.type, weight: "semibold")
  #datetime(day: 1, year: entry.year, month: entry.month).display("[month repr:short] [year]") - #typestring #entry.event, #entry.title

]
]


= Research Visits

#resume-item[
  - BigUniv, Industrial and Systems Engineering, May 2024
  - CoolSchool, Institute of Applied Mathematics, March 2023
]

= Teaching Activities

#let teaching_date = toml("teaching.toml")

#for entry in teaching_date.teaching_experience [
  #resume-entry(
    title: entry.course,
    location: entry.institution,
    date: entry.period,
    description: [#entry.at("program", default: "")],
    
  )

]

// This section is inspired by the original template, feel free to adapt for your needs
= Projects

#resume-entry(
  title: "FrankWolfe.jl",
  location: [#github-link("ZIB-IOL/FrankWolfe.jl")],
  date: "Feb. 2021 - Present",
  description: "Designer/Developer",
)

= Competitive Funding

#resume-item[
- Travel grant from Institution, to attend BigConf, 2024
- Young Investigator Grant, BigLab, funding the Ph.D. of ABC, 2023
]

= Community Service

== Reviewing activities

Mathematical Programming,
Computers and Operations Research
CPAIOR 24 PC member.

== Conference Organization

BigConf 2025, PC member.

== Other Service

#resume-item[
  - Selection committee member, assistant professor position, Big School, 2024
]
