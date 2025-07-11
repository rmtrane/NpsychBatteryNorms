#' Demo Data
#'
#' A completely made up demo data set meant to mimic the structure of
#' the NACC data. While IDs look like valid NACC IDs, these are simply the
#' characters "NACC" with six random digits. Similarly, birth and visit dates 
#' are randomly created, and so are all scores with the only constraint that
#' -4's are believable. (For example, if OTRAILA is -4, so is OTRAILB.)
#'
#' @format ## `demo_data`
#' The data set contains the columns listed below. Each column name is
#' accompanied with its short description from the `rdd` object. For more
#' info on any of the variables, see `rdd[[col]]` (replace `col` with 
#' column name).
#' \describe{
#'    \item{NACCID}{Subject ID number}
#'    \item{NACCAGE}{Subject's age at visit}
#'    \item{SEX}{Subject's sex}
#'    \item{EDUC}{Years of education}
#'    \item{BIRTHYR}{Subject's year of birth}
#'    \item{BIRTHMO}{Subject's month of birth}
#'    \item{VISITYR}{Form date - year}
#'    \item{VISITMO}{Form date - month}
#'    \item{VISITDAY}{Form date - day}
#'    \item{RACE}{Race}
#'    \item{CDRGLOB}{Global CDR}
#'    \item{MOCATOTS}{MoCA Total Raw Score - uncorrected}
#'    \item{MOCBTOTS}{MoCA-Blind Total Raw Score � uncorrected}
#'    \item{TRAILA}{Trail Making Test Part A - Total number of seconds to complete}
#'    \item{TRAILARR}{Part A - Number of commission errors}
#'    \item{TRAILALI}{Part A - Number of correct lines}
#'    \item{OTRAILA}{Oral Trail Making Test Part A � Total number of seconds to complete}
#'    \item{OTRLARR}{Oral Trail Making Test Part A � Number of commission errors}
#'    \item{DIGFORCT}{Number Span Test: Forward - Number of correct trials}
#'    \item{DIGFORSL}{Number Span Test: Forward - Longest span forward}
#'    \item{DIGBACCT}{Number Span Test: Backward - Number of correct trials}
#'    \item{DIGBACLS}{Number Span Test: Backward - Longest span backward}
#'    \item{WAIS}{WAIS-R Digit Symbol}
#'    \item{MINTTOTS}{Multilingual Naming Test (MINT) - Total score}
#'    \item{ANIMALS}{Animals - Total number of animals named in 60 seconds}
#'    \item{VEG}{Vegetables - Total number of vegetables named in 60 seconds}
#'    \item{UDSVERTN}{Total number of correct F-words and L-words}
#'    \item{UDSVERFC}{Number of correct F-words generated in 1 minute}
#'    \item{UDSVERLC}{Number of correct L-words generated in 1 minute}
#'    \item{UDSBENTC}{Total Score for copy of Benson figure}
#'    \item{UDSBENTD}{Total score for 10- to 15-minute delayed drawing of Benson figure}
#'    \item{CRAFTVRS}{Craft Story 21 Recall (Immediate) - Total story units recalled, verbatim scoring}
#'    \item{CRAFTURS}{Craft Story 21 Recall (Immediate) - Total story units recalled, paraphrase scoring}
#'    \item{CRAFTDVR}{Craft Story 21 Recall (Delayed) - Total story units recalled, verbatim scoring}
#'    \item{CRAFTDRE}{Craft Story 21 Recall (Delayed) - Total story units recalled, paraphrase scoring}
#'    \item{REY1REC}{Rey Auditory Verbal Learning (Immediate) Trial 1 Total recall}
#'    \item{REY2REC}{Rey Auditory Verbal Learning (Immediate) Trial 2 Total recall}
#'    \item{REY3REC}{Rey Auditory Verbal Learning (Immediate) Trial 3 Total recall}
#'    \item{REY4REC}{Rey Auditory Verbal Learning (Immediate) Trial 4 Total recall}
#'    \item{REY5REC}{Rey Auditory Verbal Learning (Immediate) Trial 5 Total recall}
#'    \item{REY6REC}{Rey Auditory Verbal Learning (Immediate) Trial 6 Total recall}
#'    \item{REYDREC}{Rey Auditory Verbal Learning (Delayed)  - Total Recall}
#'    \item{REYTCOR}{Rey Auditory Verbal Learning (Delayed) Recognition � Total correct}
#'    \item{TRAILB}{Trail Making Test Part B - Total number of seconds to complete}
#'    \item{TRAILBLI}{Part B - Number of correct lines}
#'    \item{TRAILBRR}{Part B - Number of commission errors}
#'    \item{MOCACLOC}{MoCA: Visuospatial/executive - Clock contour}
#'    \item{MOCACLOH}{MoCA: Visuospatial/executive - Clock hands}
#'    \item{MOCACLON}{MoCA: Visuospatial/executive - Clock numbers}
#'    \item{OTRAILB}{Oral Trail Making Test Part B �  Total number of seconds to complete}
#'    \item{OTRLBRR}{Oral Trail Making Test Part B � Number of commission errors}
#'    \item{OTRLBLI}{Oral Trail Making Test Part B � Number of correct lines}
#'    \item{NACCGDS}{Total GDS Score}
#'    \item{CDRSUM}{Standard CDR sum of boxes}
#'    \item{UDSBENRS}{Benson Complex Figure Recall - Recognized original stimulus among four options}
#'    \item{BILLS}{In the past four weeks, did the subject have any difficulty or need help with: Writing checks, paying bills, or balancing a checkbook}
#'    \item{TAXES}{In the past four weeks, did the subject have any difficulty or need help with: Assembling tax records, business affairs, or other papers}
#'    \item{SHOPPING}{In the past four weeks, did the subject have any difficulty or need help with: Shopping alone for clothes, household necessities, or groceries}
#'    \item{GAMES}{In the past four weeks, did the subject have any difficulty or need help with: Playing a game of skill such as bridge or chess, working on a hobby}
#'    \item{STOVE}{In the past four weeks, did the subject have any difficulty or need help with: Heating water, making a cup of coffee, turning off the stove}
#'    \item{MEALPREP}{In the past four weeks, did the subject have any difficulty or need help with: Preparing a balanced meal}
#'    \item{EVENTS}{In the past four weeks, did the subject have any difficulty or need help with: Keeping track of current events}
#'    \item{PAYATTN}{In the past four weeks, did the subject have any difficulty or need help with: Paying attention to and understanding a TV program, book, or magazine}
#'    \item{REMDATES}{In the past four weeks, did the subject have any difficulty or need help with: Remembering appointments, family occasions, holidays, medications}
#'    \item{TRAVEL}{In the past four weeks, did the subject have any difficulty or need help with: Traveling out of the neighborhood, driving, or arranging to take public transportation}
#'    \item{REYFPOS}{Rey Auditory Verbal Learning (Delayed) Recognition � Total false positive}
#'    \item{NACCUDSD}{Cognitive status at UDS visit}
#'    \item{NACCMMSE}{Total MMSE score (using D-L-R-O-W)}
#'    \item{BOSTON}{Boston Naming Test (30) - Total score}
#'    \item{LOGIMEM}{Total number of story units recalled from this current test administration}
#'    \item{MEMUNITS}{Logical Memory IIA - Delayed - Total number of story units recalled}
#'    \item{MEMTIME}{Logical Memory IIA - Delayed - Time elapsed since Logical Memory IA - Immediate}
#'    \item{DIGIF}{Digit span forward trials correct}
#'    \item{DIGIFLEN}{Digit span forward length}
#'    \item{DIGIB}{Digit span backward trials correct}
#'    \item{DIGIBLEN}{Digit span backward length}
#'    \item{OTHCOG}{Presumptive etiologic diagnosis - Other neurological, genetic, or infectious condition}
#'    \item{OTHCOGX}{Presumptive etiologic diagnosis of the cognitive disorder - Other neurological, genetic, or infectious condition (specify)}
#'    \item{OTHPSY}{Presumptive etiologic diagnosis - Other psychiatric disease}
#'    \item{OTHPSYX}{Presumptive etiologic diagnosis of the cognitive disorder - Other psychiatric disease (specify)}
#'    \item{COGOTH}{Presumptive etiologic diagnosis of the cognitive disorder - Other 1 (specify)}
#'    \item{COGOTHIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Other 1 (specify)}
#'    \item{COGOTHX}{Other presumptive etiologic diagnosis of the cognitive disorder 1, specify}
#'    \item{COGOTH2}{Presumptive etiologic diagnosis of the cognitive disorder - Other 2 (specify)}
#'    \item{COGOTH2F}{Primary, contributing, or non-contributing cause of cognitive impairment - Other 2 (specify)}
#'    \item{COGOTH2X}{Other presumptive etiologic diagnosis of the cognitive disorder 2, specify}
#'    \item{COGOTH3}{Presumptive etiologic diagnosis of the cognitive disorder - Other 3 (specify)}
#'    \item{COGOTH3X}{Other presumptive etiologic diagnosis of the cognitive disorder 3, specify}
#'    \item{ALCDEM}{Presumptive etiologic diagnosis of the cognitive disorder - Cognitive impairment due to alcohol abuse}
#'    \item{ALCDEMIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Alcohol abuse}
#'    \item{ANXIET}{Presumptive etiologic diagnosis - Anxiety}
#'    \item{ANXIETIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Anxiety}
#'    \item{BIPOLDX}{Presumptive etiologic diagnosis - Bipolar disorder}
#'    \item{BIPOLDIF}{Primary, contributing, or non-contributing cause of cognitive impairment - bipolar disorder}
#'    \item{BRNINJ}{Presumptive etiologic diagnosis - Traumatic brain injury (TBI)}
#'    \item{BRNINJIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Traumatic brain injury (TBI)}
#'    \item{CORT}{Presumptive etiologic diagnosis - Corticobasal degeneration (CBD)}
#'    \item{CORTIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Corticobasal degeneration (CBD)}
#'    \item{CVD}{Presumptive etiologic diagnosis - Vascular brain injury (VBI)}
#'    \item{CVDIF}{Primary, contributing, or non-contributing cause of cognitive impairment - vascular brain injury}
#'    \item{DELIR}{Presumptive etiologic diagnosis - Delirium}
#'    \item{DELIRIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Delirium}
#'    \item{DEMUN}{Presumptive etiologic diagnosis of the cognitive disorder - Undetermined etiology}
#'    \item{DEMUNIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Undetermined etiology}
#'    \item{DEP}{Presumptive etiologic diagnosis - Depression}
#'    \item{DEPIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Depression}
#'    \item{DOWNS}{Presumptive etiologic diagnosis of the cognitive disorder - Down syndrome}
#'    \item{DOWNSIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Down syndrome}
#'    \item{DYSILL}{Presumptive etiologic diagnosis of the cognitive disorder - Cognitive impairment due to systemic disease/medical illness}
#'    \item{DYSILLIF}{Primary, contributing, or non-contributing cause of cognitive impairment - systemic disease/medical illness}
#'    \item{EPILEP}{Presumptive etiologic diagnosis - Epilepsy}
#'    \item{EPILEPIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Epilepsy}
#'    \item{ESSTREM}{Presumptive etiologic diagnosis - Essential tremor}
#'    \item{ESSTREIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Essential tremor}
#'    \item{FTLDMO}{Presumptive etiologic diagnosis - FTLD with motor neuron disease (MND)}
#'    \item{FTLDMOIF}{Primary, contributing, or non-contributing cause of cognitive impairment - FTLD with motor neuron disease (MND)}
#'    \item{FTLDNOS}{Presumptive etiologic diagnosis of the cognitive disorder - FTLD not otherwise specified (NOS)}
#'    \item{FTLDNOIF}{Primary, contributing, or non-contributing cause of cognitive impairment - FTLD not otherwise specified (NOS)}
#'    \item{HIV}{Presumptive etiologic diagnosis - Human immunodeficiency virus (HIV)}
#'    \item{HIVIF}{Primary, contributing, or non-contributing cause of cognitive impairment - HIV}
#'    \item{HUNT}{Presumptive etiologic diagnosis of the cognitive disorder - Huntington's disease}
#'    \item{HUNTIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Huntington's disease}
#'    \item{HYCEPH}{Presumptive etiologic diagnosis of the cognitive disorder - Normal-pressure hydrocephalus (NPH)}
#'    \item{HYCEPHIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Normal-pressure hydrocephalus (NPH)}
#'    \item{IMPSUB}{Presumptive etiologic diagnosis of the cognitive disorder - Cognitive impairment due to other substance abuse}
#'    \item{IMPSUBIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Other substance abuse}
#'    \item{MEDS}{Presumptive etiologic diagnosis of the cognitive disorder - Cognitive impairment due to medications}
#'    \item{MEDSIF}{Primary, contributing, or non-contributing cause of cognitive impairment - medications}
#'    \item{MSA}{Presumptive etiologic diagnosis - Multiple system atrophy (MSA)}
#'    \item{MSAIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Multiple system atrophy (MSA)}
#'    \item{NACCALZD}{Presumptive etiologic diagnosis of the cognitive disorder - Alzheimer's disease}
#'    \item{NACCALZP}{Primary, contributing, or non-contributing cause of observed cognitive impairment - Alzheimer's disease (AD)}
#'    \item{NACCLBDE}{Presumptive etiologic diagnosis - Lewy body disease}
#'    \item{NACCLBDP}{Primary, contributing, or non-contributing cause of cognitive impairment - Lewy body disease (LBD)}
#'    \item{NEOP}{Presumptive etiologic diagnosis - CNS neoplasm}
#'    \item{NEOPIF}{Primary, contributing, or non-contributing cause of cognitive impairment - CNS neoplasm}
#'    \item{OTHCOGIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Other neurological, genetic, or infectious condition}
#'    \item{OTHPSYIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Other psychiatric disease}
#'    \item{POSSAD}{Presumptive etiologic diagnosis of the cognitive disorder - Possible Alzheimer's disease}
#'    \item{POSSADIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Possible Alzheimer's disease}
#'    \item{PPAPH}{Presumptive etiologic diagnosis of the cognitive disorder - Primary progressive aphasia (PPA)}
#'    \item{PPAPHIF}{Primary, contributing, or non-contributing cause of cognitive impairment - primary progressive aphasia (PPA)}
#'    \item{PRION}{Presumptive etiologic diagnosis of the cognitive disorder - Prion disease (CJD, other)}
#'    \item{PRIONIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Prion disease (CJD, other)}
#'    \item{PROBAD}{Presumptive etiologic diagnosis of the cognitive disorder - Probable Alzheimer's disease}
#'    \item{PROBADIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Probable Alzheimer's disease}
#'    \item{PSP}{Presumptive etiologic diagnosis - primary supranuclear palsy (PSP)}
#'    \item{PSPIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Primary supranuclear palsy (PSP)}
#'    \item{PTSDDX}{Presumptive etiologic diagnosis - Post-traumatic stress disorder (PTSD)}
#'    \item{PTSDDXIF}{Primary, contributing, or non-contributing cause of cognitive impairment - PTSD}
#'    \item{SCHIZOP}{Presumptive etiologic diagnosis - Schizophrenia or other psychosis}
#'    \item{SCHIZOIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Schizophrenia or other psychosis}
#'    \item{STROKE}{Presumptive etiologic diagnosis - Stroke}
#'    \item{STROKIF}{Primary, contributing, or non-contributing cause of cognitive impairment - stroke}
#'    \item{VASC}{Presumptive etiologic diagnosis of the cognitive disorder - Probable vascular dementia (NINDS/AIREN criteria)}
#'    \item{VASCIF}{Primary, contributing, or non-contributing cause of cognitive impairment - Probable vascular dementia (NINDS/AIREN criteria)}
#'    \item{VASCPS}{Presumptive etiologic diagnosis of the cognitive disorder - Possible vascular dementia (NINDS/AIREN criteria)}
#'    \item{VASCPSIF}{Primary, contributing, or non-contributing cause of cognitive impairment - possible vascular dementia (NINDS/AIREN criteria)}
#' }
#'
"demo_data"
