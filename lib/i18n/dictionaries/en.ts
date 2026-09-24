import type { Dictionary } from "../dictionaryType";

const en: Dictionary = {
  common: {
    siteName: "Find My Benefits",
    home: "Home",
    loading: "Loading...",
    detailLink: "View details",
    caseCountSuffix: " programs",
  },
  header: {
    searchPlaceholder: "Search benefits",
    searchAriaLabel: "Search",
    navFinder: "Finder",
    navAbout: "About",
    navContact: "Contact",
  },
  footer: {
    tagline:
      "Find government benefits by life event — marriage, pregnancy & childcare, children & teens, young adults, housing, seniors, and multicultural families — organized by region.",
    disclaimer:
      "This site is a private information service that organizes government and local-government support programs for easier reading. It is not an official government or local-government website. Please confirm the latest details on each program's official page before applying.",
    categoriesHeading: "Categories",
    toolsHeading: "Free Tools",
    siteHeading: "Site",
    toolSearch: "Search benefits",
    toolFinder: "Benefit finder",
    toolMedianIncome: "Median income table",
    linkAbout: "About this site",
    linkPrivacy: "Privacy Policy",
    linkTerms: "Terms of Use",
    linkContact: "Contact us",
    copyrightSuffix: "Find My Benefits. All rights reserved.",
  },
  home: {
    metaTitle: "Find My Benefits | Government & Local Support Programs by Region",
    metaDescription:
      "Easily find government and local-government support programs and benefits by life event — marriage, pregnancy, children & teens, young adults, housing, seniors, multicultural families — and by region.",
    eyebrow: "Support programs by region and life stage",
    heroTitleLine1: "Find support programs",
    heroTitleLine2: "in your area, at a glance",
    heroDescription:
      "We've organized government and local-government support programs by region for life events like marriage, pregnancy & childcare, children & teens, young adults, housing, seniors, and multicultural families.",
    toolsHeading: "Free Tools",
    categoriesHeading: "Browse by category",
    filterEmpty: "No programs match these conditions yet.",
    introHeading: "What Find My Benefits offers",
    introParagraph1:
      "Korea's 17 provinces/metropolitan cities and many districts each run their own support programs for marriage, pregnancy & childcare, children & teens, young adults, housing, seniors, and multicultural families — but names and conditions vary so much by local government that it's easy to miss benefits you're actually eligible for. Find My Benefits organizes eligibility, support amounts, and application methods in plain language based on each local government's official notices and public data, so you can compare and check everything in one place.",
    introParagraph2Pre:
      "You can browse by filtering on region and category, search directly for a program you're looking for, or use our free ",
    introLinkText: "Benefit Finder",
    introParagraph2Post:
      " tool, which picks out matching programs once you enter your region, age, and household type. Each benefit page also includes the documents and checklist to prepare before applying, plus frequently asked questions, so even first-time applicants can prepare with confidence.",
    introParagraph3:
      "Please note that Find My Benefits is not an official government or local-government website. Support programs can change at any time due to budget exhaustion or ordinance revisions, so before applying, always double-check the latest standards on the official link provided on each page.",
    officialLinksHeading: "Official Sites",
    officialLinksDescription: "Official government portals for checking benefits.",
  },
  tools: {
    searchTitle: "Search benefits",
    searchDescription: "Find the benefit you're looking for by program name, region, or keyword.",
    finderTitle: "Benefit Finder",
    finderDescription: "Enter your region, age, and household type to get matching benefits.",
    medianIncomeTitle: "Median income table",
    medianIncomeDescription: "Check median income amounts by household size and percentage at a glance.",
  },
  officialLinks: {
    bokjiroTitle: "Bokjiro (복지로)",
    bokjiroDescription: "Integrated welfare service search and online application",
    gov24Title: "Gov24 (정부24)",
    gov24Description: "Integrated government civil affairs and service portal",
    youthCenterTitle: "On-tong Youth (온통청년)",
    youthCenterDescription: "Integrated youth policy information platform",
  },
  recentlyViewed: {
    heading: "Recently viewed",
  },
  filterBar: {
    regionLabel: "Region",
    allRegions: "All regions",
    categoryLabel: "Category",
    allCategories: "All categories",
  },
  pagination: {
    ariaLabel: "Page navigation",
    previous: "Previous",
    next: "Next",
  },
  benefitCard: {
    detailLink: "View details",
  },
  category: {
    titleSuffix: "Benefits",
    metaTitleSuffix: "Benefits & Support Programs",
    defaultDescriptionSuffix: "related support programs.",
    emptyList: "No benefits have been registered yet.",
  },
  region: {
    badgeLabel: "Benefits by region",
    titleSuffix: "Benefits",
    description: ": browse support programs you can apply for, by category.",
    emptyListPrefix: "No benefits have been registered yet for ",
    emptyListSuffix: ".",
  },
  search: {
    metaSearchResultsSuffix: "search results",
    metaDefaultTitle: "Search benefits",
    heading: "Search benefits",
    placeholder: "Search by benefit, region, or program name",
    emptyPrompt: "Try searching for a benefit, region, or program name. (e.g. youth housing, Seoul, childbirth grant)",
    noResultsTemplate: 'No search results for "{query}". Try a different keyword or region name.',
    resultsTemplate: 'Search results for "{query}": {count} results',
  },
  finder: {
    metaTitle: "Benefit Finder",
    metaDescription: "Enter your region, age, and household type to find matching benefits right away.",
    heading: "Benefit Finder",
    description: "Enter your region, age, and household type to find matching benefits right away.",
    regionLabel: "Region of residence",
    allRegions: "All regions",
    regionAllSuffix: " (all)",
    ageLabel: "Age (optional)",
    agePlaceholder: "e.g. 28",
    householdLabel: "Household type (optional)",
    householdAll: "All",
    householdSingle: "Single-person household",
    householdNewlywed: "Newlywed couple",
    categoryLabel: "Categories of interest (optional, multiple selection allowed)",
    submitButton: "Find my benefits",
    resultsCountPrefix: "Benefits matching your conditions: ",
    resultsCountSuffix: "",
    noResults: "No benefits matched your conditions. Try adjusting the region or age.",
    disclaimer:
      "These results are a first-pass filter based only on region, age, and household type. Please always double-check detailed conditions like income requirements on each benefit's detail page.",
  },
  medianIncome: {
    metaTitle: "Median Income Table",
    metaDescriptionTemplate: " and {year2} median income at a glance, by household size and percentage.",
    heading: "Median Income Table",
    description:
      'Each benefit shows an income condition like "median income 100% or below" with a different percentage. This table lets you look up the actual monthly income amount (KRW) for a given household size and percentage. Since the median income standard is announced anew each year, and some benefits still use a previously announced year (e.g. {year2}), we provide the two most recent years together.',
    tableHeading: " Median Income Table",
    householdSizeHeader: "Household size",
    householdUnit: "-person household",
    sourcePrefix: "Source: Ministry of Health and Welfare,",
    sourceYearSuffix: " median income notice",
    sourceLinkText: "Link",
    note9PlusLabel: "9+ person households",
    note9PlusBody:
      ": calculated by adding the per-person increase for that year (specified in the source notice below each year's table) to the 8-person base amount for each additional person.",
    noteDisclaimer:
      "This table is a reference calculated from the median income (100%) announced yearly by the Ministry of Health and Welfare. The actual income assessment used for benefit screening is calculated separately by converting income and assets, so it may differ from this table. For an accurate determination, use the Bokjiro simulation or contact the agency handling the benefit you're applying for.",
  },
  benefitDetail: {
    ageRangeTemplate: "Age {min}–{max}",
    ageSingleTemplate: "Age {age}",
    tocEligibility: "Eligibility",
    tocSupportContent: "Support details",
    tocApplicationMethod: "How to apply",
    tocChecklist: "Checklist before applying",
    tocFaq: "FAQ",
    breadcrumbHome: "Home",
    expiredNoticePrefix: "This page contains information that ended in",
    expiredNoticeSuffix: ". It can no longer be used to apply.",
    expiredNoticeLink: "View the latest information",
    yearlyViewLabel: "View by year",
    yearSuffix: "",
    eligibilityHeading: "Eligibility",
    supportContentHeading: "Support details",
    applicationMethodHeading: "How to apply",
    requiredDocumentsHeading: "Required documents",
    checklistHeading: "Checklist before applying",
    faqHeading: "FAQ",
    relatedBenefitsHeadingDefault: "Related benefits",
    relatedBenefitsHeadingRegionSuffix: ": other benefits",
    agencyLabel: "Managing agency:",
    officialLinkButton: "Check the official page",
    sourcePrefix: "Source:",
    sourceUpdatedSuffix: "as of",
    sourceDisclaimer: "Always double-check the latest official guidance for accurate, up-to-date standards.",
    shareButton: "Share",
    shareCopied: "Link copied",
    tocLabel: "Contents",
  },
  aboutPage: {
    metaTitle: "About",
    metaDescription: "About the Find My Benefits service.",
    heading: "About",
    paragraph1:
      "Find My Benefits is an information service that organizes support programs run by local governments across Korea — for marriage, pregnancy & childcare, children & teens, young adults, housing, seniors, and multicultural families — so you can compare and check them all in one place.",
    paragraph2:
      "Program names and conditions vary slightly from one local government to another, so people often miss out on support they actually need. We summarize eligibility, support details, and application methods in plain language based on public data, along with a checklist to review before applying.",
    paragraph3:
      "Please note that this site is not an official government or local-government website. The information here is for reference only — always confirm the latest standards on each program's official information page before applying. If any information is inaccurate or needs updating, please let us know via the Contact page and we'll update it promptly.",
  },
  privacyPage: {
    metaTitle: "Privacy Policy",
    metaDescription: "Privacy Policy of Find My Benefits.",
    heading: "Privacy Policy",
    section1Heading: "1. Personal information collected",
    section1Body:
      "This site may collect selections such as age range, region of residence, and household type while checking benefit conditions; these inputs are not transmitted to or stored on a server, and are used only within the user's browser. Contact information left via the Contact page is used only to respond to the inquiry.",
    section2Heading: "2. Cookies and advertising",
    section2Body:
      "This site displays ads through Google AdSense. Google and other third-party ad providers may use cookies to serve ads based on a user's prior visits to this or other sites. Users can disable personalized ads on Google's Ad Settings page.",
    section3Heading: "3. Retention and use period of personal information",
    section3Body:
      "Information collected via inquiries is destroyed without delay after the response is complete. We do not offer membership sign-up or any other personal information storage feature.",
    section4Heading: "4. Contact",
    section4Body: "For privacy-related inquiries, please use the Contact page.",
    lastUpdated: "Last updated: September 2026",
  },
  termsPage: {
    metaTitle: "Terms of Use",
    metaDescription: "Terms of Use of Find My Benefits.",
    heading: "Terms of Use",
    section1Heading: "1. Nature of the service",
    section1Body:
      "This site is a private information service that organizes support program information based on public data disclosed by government and local governments; it is not an official government or local-government website.",
    section2Heading: "2. Accuracy of information",
    section2Body:
      "The benefit information provided is for reference only and may differ from actual program details due to policy changes or budget exhaustion. Before applying, always confirm the latest information via each program's official information page or the responsible agency; we are not liable for any disadvantage arising solely from reliance on this site's information.",
    section3Heading: "3. External links",
    section3Body:
      "This site may provide external links to the official application pages of each support program, and is not responsible for the content of external sites.",
    section4Heading: "4. Changes to these terms",
    section4Body: "These terms may be changed as needed for service operation, with prior notice.",
    lastUpdated: "Last updated: September 2026",
  },
  contactPage: {
    metaTitle: "Contact",
    metaDescription: "Report an information error, or reach out about partnerships or advertising.",
    heading: "Contact",
    body: "Please email us below to report an error in benefit information, request a new region or program, or inquire about partnerships and advertising.",
  },
  notFound: {
    heading: "Page not found",
    body: "The benefit information you requested does not exist or has been removed.",
    homeLink: "Back to home",
  },
};

export default en;
