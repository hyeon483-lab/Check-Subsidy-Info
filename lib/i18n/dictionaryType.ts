export interface Dictionary {
  common: {
    siteName: string;
    home: string;
    loading: string;
    detailLink: string;
    caseCountSuffix: string;
  };
  header: {
    searchPlaceholder: string;
    searchAriaLabel: string;
    navFinder: string;
    navAbout: string;
    navContact: string;
  };
  footer: {
    tagline: string;
    disclaimer: string;
    categoriesHeading: string;
    toolsHeading: string;
    siteHeading: string;
    toolSearch: string;
    toolFinder: string;
    toolMedianIncome: string;
    linkAbout: string;
    linkPrivacy: string;
    linkTerms: string;
    linkContact: string;
    copyrightSuffix: string;
  };
  home: {
    metaTitle: string;
    metaDescription: string;
    eyebrow: string;
    heroTitleLine1: string;
    heroTitleLine2: string;
    heroDescription: string;
    toolsHeading: string;
    categoriesHeading: string;
    filterEmpty: string;
    introHeading: string;
    introParagraph1: string;
    introParagraph2Pre: string;
    introLinkText: string;
    introParagraph2Post: string;
    introParagraph3: string;
    officialLinksHeading: string;
    officialLinksDescription: string;
  };
  tools: {
    searchTitle: string;
    searchDescription: string;
    finderTitle: string;
    finderDescription: string;
    medianIncomeTitle: string;
    medianIncomeDescription: string;
  };
  officialLinks: {
    bokjiroTitle: string;
    bokjiroDescription: string;
    gov24Title: string;
    gov24Description: string;
    youthCenterTitle: string;
    youthCenterDescription: string;
  };
  recentlyViewed: {
    heading: string;
  };
  filterBar: {
    regionLabel: string;
    allRegions: string;
    categoryLabel: string;
    allCategories: string;
  };
  pagination: {
    ariaLabel: string;
    previous: string;
    next: string;
  };
  benefitCard: {
    detailLink: string;
  };
  category: {
    titleSuffix: string;
    metaTitleSuffix: string;
    defaultDescriptionSuffix: string;
    emptyList: string;
  };
  region: {
    badgeLabel: string;
    titleSuffix: string;
    description: string;
    emptyListPrefix: string;
    emptyListSuffix: string;
  };
  search: {
    metaSearchResultsSuffix: string;
    metaDefaultTitle: string;
    heading: string;
    placeholder: string;
    emptyPrompt: string;
    /** Contains a literal "{query}" placeholder. */
    noResultsTemplate: string;
    /** Contains literal "{query}" and "{count}" placeholders. */
    resultsTemplate: string;
  };
  finder: {
    metaTitle: string;
    metaDescription: string;
    heading: string;
    description: string;
    regionLabel: string;
    allRegions: string;
    regionAllSuffix: string;
    ageLabel: string;
    agePlaceholder: string;
    householdLabel: string;
    householdAll: string;
    householdSingle: string;
    householdNewlywed: string;
    categoryLabel: string;
    submitButton: string;
    resultsCountPrefix: string;
    resultsCountSuffix: string;
    noResults: string;
    disclaimer: string;
  };
  medianIncome: {
    metaTitle: string;
    metaDescriptionTemplate: string;
    heading: string;
    description: string;
    tableHeading: string;
    householdSizeHeader: string;
    householdUnit: string;
    sourcePrefix: string;
    sourceYearSuffix: string;
    sourceLinkText: string;
    note9PlusLabel: string;
    note9PlusBody: string;
    noteDisclaimer: string;
  };
  benefitDetail: {
    /** Contains literal "{min}" and "{max}" placeholders. */
    ageRangeTemplate: string;
    /** Contains a literal "{age}" placeholder. */
    ageSingleTemplate: string;
    tocEligibility: string;
    tocSupportContent: string;
    tocApplicationMethod: string;
    tocChecklist: string;
    tocFaq: string;
    breadcrumbHome: string;
    expiredNoticePrefix: string;
    expiredNoticeSuffix: string;
    expiredNoticeLink: string;
    yearlyViewLabel: string;
    yearSuffix: string;
    eligibilityHeading: string;
    supportContentHeading: string;
    applicationMethodHeading: string;
    requiredDocumentsHeading: string;
    checklistHeading: string;
    faqHeading: string;
    relatedBenefitsHeadingDefault: string;
    relatedBenefitsHeadingRegionSuffix: string;
    agencyLabel: string;
    officialLinkButton: string;
    sourcePrefix: string;
    sourceUpdatedSuffix: string;
    sourceDisclaimer: string;
    shareButton: string;
    shareCopied: string;
    tocLabel: string;
  };
  aboutPage: {
    metaTitle: string;
    metaDescription: string;
    heading: string;
    paragraph1: string;
    paragraph2: string;
    paragraph3: string;
  };
  privacyPage: {
    metaTitle: string;
    metaDescription: string;
    heading: string;
    section1Heading: string;
    section1Body: string;
    section2Heading: string;
    section2Body: string;
    section3Heading: string;
    section3Body: string;
    section4Heading: string;
    section4Body: string;
    lastUpdated: string;
  };
  termsPage: {
    metaTitle: string;
    metaDescription: string;
    heading: string;
    section1Heading: string;
    section1Body: string;
    section2Heading: string;
    section2Body: string;
    section3Heading: string;
    section3Body: string;
    section4Heading: string;
    section4Body: string;
    lastUpdated: string;
  };
  contactPage: {
    metaTitle: string;
    metaDescription: string;
    heading: string;
    body: string;
  };
  notFound: {
    heading: string;
    body: string;
    homeLink: string;
  };
}
