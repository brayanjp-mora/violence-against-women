# Attitudes and Prevalence of Intimate Partner Violence

A cross-country data visualization exploring the association between **attitudes toward violence against partners** (World Values Survey) and the **reported prevalence of former or current intimate partner violence** (SDG indicator 5.2.1).

> ⚠️ **Note:** This project is descriptive. It shows an association between two cross-sectional measures from different sources — it does not claim any causal relationship.

## Data sources

| Source | Variable |
|---|---|
| [World Values Survey, Wave 7](https://www.worldvaluessurvey.org/WVSDocumentationWV7.jsp) | Q189 — *"Is it justifiable for a man to beat his wife?"* (1 = never, 10 = always) |
| [UN Global SDG Database](https://unstats.un.org/sdgs/dataportal) | Indicator 5.2.1 — roportion of ever-partnered women and girls aged 15 years and older subjected to physical, sexual or psychological violence by a current or former intimate partner in the previous 12 months, by form of violence and by age | 

## Outputs

- **Scatter plot** — country-level mean justifiability score (x) vs. IPV prevalence (y), colored by region.
- **Bivariate choropleth** — both variables classified into tertiles and crossed into a 3×3 color scheme.

## Methodology (Ongoing)

1. 
2. 

## Limitations

- Survey years differ (WVS Wave 7: 2017–2022; SDG estimates anchored to a reference year: 2023).
- WVS covers a subset of countries; the map shows missing data as gray.
- Prevalence relies on self-reports and may be under-reported where stigma is highest.

## Repository structure

```
violence-against-women/
├── data/
│   ├── raw/          # original downloads (not tracked)
│   └── processed/    # cleaned, merged country-level data
├── output/           # final figures and/or tables
├── scripts/          # cleaning and plotting scripts
├──.gitignore         # ignored files
└── README.md
```

## License & citation
Data belong to their original providers (WVS Association, UN/WHO). Please cite them directly if you reuse this work.

Haerpfer, C., Inglehart, R., Moreno, A., Welzel, C., Kizilova, K., Diez-Medrano J., M. Lagos, P.
Norris, E. Ponarin & B. Puranen (eds.). 2024. World Values Survey: Round Seven – Country-Pooled
Datafile Version 6.0.0. Madrid, Spain & Vienna, Austria: JD Systems Institute & WVSA Secretariat.
doi:10.14281/18241.24. https://www.worldvaluessurvey.org/WVSDocumentationWV7.jsp

United Nations Statistics Division. 2026. Global SDG Indicators Data Platform. United Nations. 
Accessed August 10, 2026. https://unstats.un.org/sdgs/dataportal
