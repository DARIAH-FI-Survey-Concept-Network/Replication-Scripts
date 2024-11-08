#### REPLICATION SCRIPT ####

set.seed(4321) # so that the visualisations are identical.

library(finnsurveytext)

## PREPARE ##
prepd_df <- fst_prepare(dev_coop,
                        question = "q11_3",
                        id = "fsd_id",
                        stopword_list = "nltk",
                        model = "ftb",
                        weights = "paino",
                        add_cols = "gender"
)

## PREPARE FROM svydesign ##
svy_dev_coop <- survey::svydesign(id = ~1,
                                  weights = ~paino,
                                  data = dev_coop
)
prepd_df_2 <- fst_prepare_svydesign(svydesign = svy_dev_coop,
                                    question = 'q11_3',
                                    id = 'fsd_id',
                                    model = 'ftb',
                                    use_weights = TRUE,
                                    add_cols = 'gender'
)

## SUMMARY TABLES ##
fst_summarise(prepd_df, desc = 'All')
fst_pos(prepd_df)
fst_length_summary(prepd_df, desc = "All")

## WORDCLOUDS ##
fst_wordcloud(prepd_df)
dev.off() # so that next wordcloud prints correctly

fst_wordcloud(prepd_df, use_column_weights = TRUE)

## N-GRAM PLOTS ##
fst_freq(prepd_df, use_column_weights = TRUE)
fst_ngrams(prepd_df, ngrams = 2, use_column_weights = TRUE)

## CONCEPT NETWORK
fst_concept_network(prepd_df,
                    concepts = "köyhyys, nälänhätä, sota",
                    title = "Q11_3",
                    norm = "number_resp"
)

## COMPARISON SUMMARY TABLES
fst_summarise_compare(prepd_df,
                      field = 'gender',
                      exclude_nulls = FALSE,
                      rename_nulls = 'Gender NA'
)

fst_pos_compare(prepd_df,
                   field = 'gender',
                   exclude_nulls = FALSE,
                   rename_nulls = 'Gender NA'
)

fst_length_compare(prepd_df,
                   field = 'gender',
                   incl_sentences = TRUE,
                   exclude_nulls = FALSE,
                   rename_nulls = 'Gender NA'
)

## COMPARISON N-GRAM PLOTS ##
fst_freq_compare(prepd_df,
                 'gender',
                 use_column_weights = TRUE,
                 exclude_nulls = TRUE,
                 rename_nulls = 'Gender NA'
)

## COMPARISON CONCEPT NETWORK ##
fst_concept_network_compare(prepd_df,
                            "gender",
                            concepts = 'köyhyys, nälänhätä, sota, ilmastonmuutos' ,
                            exclude_nulls = TRUE,
                            rename_nulls = 'Gender NA'
)

## English example ##

fst_find_stopwords(language = "en")
fst_print_available_models(search = "english")
prepd_en <- fst_prepare(english_sample_survey,
                        question = "text",
                        id = "id",
                        model = "english-ewt",
                        stopword_list = "nltk",
                        language = 'en')
