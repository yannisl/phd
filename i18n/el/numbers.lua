local main = main or {}

  main =  {
    el =  {
      identity =  {
        version =  {
          _cldrVersion =  "26",
          _number =  "$Revision= 10809 $"
        },
        generation =  {
          _date =  "$Date= 2014_08_14 15=10=07 _0500 (Thu, 14 Aug 2014) $"
        },
        language =  "el"
      },
      numbers =  {
        defaultNumberingSystem =  "latn",
        otherNumberingSystems =  {
          native =  "latn",
          traditional =  "grek"
        },
        minimumGroupingDigits =  "1",
        symbols_numberSystem_latn =  {
          decimal =  ",",
          group =  ".",
          list =  ";",
          percentSign =  "%",
          plusSign =  "+",
          minusSign =  "_",
          exponential =  "e",
          superscriptingExponent =  "×",
          perMille =  "‰",
          infinity =  "∞",
          nan =  "NaN",
          timeSeparator = "= ="
        },
        decimalFormats_numberSystem_latn =  {
          standard =  [[#,##0.###]],
          long =  {
            decimalFormat =  {
              ["1000_count_one"] =   "0 χιλιάδα",
              ["1000_count_other"] =   "0 χιλιάδες",
              ["10000_count_one"] =   "00 χιλιάδες",
              ["10000_count_other"] =   "00 χιλιάδες",
              ["100000_count_one"] =   "000 χιλιάδες",
              ["100000_count_other"] =   "000 χιλιάδες",
              ["1000000_count_one"] =   "0 εκατομμύριο",
              ["1000000_count_other"] =   "0 εκατομμύρια",
              ["10000000_count_one"] =   "00 εκατομμύρια",
              ["10000000_count_other"] =   "00 εκατομμύρια",
              ["100000000_count_one"] =   "000 εκατομμύρια",
              ["100000000_count_other"] =   "000 εκατομμύρια",
              ["1000000000_count_one"] =   "0 δισεκατομμύριο",
              ["1000000000_count_other"] =   "0 δισεκατομμύρια",
              ["10000000000_count_one"] =   "00 δισεκατομμύρια",
              ["10000000000_count_other"] =   "00 δισεκατομμύρια",
              ["100000000000_count_one"] =   "000 δισεκατομμύρια",
              ["100000000000_count_other"] =   "000 δισεκατομμύρια",
              ["1000000000000_count_one"] =   "0 τρισεκατομμύριο",
              ["1000000000000_count_other"] =   "0 τρισεκατομμύρια",
              ["10000000000000_count_one"] =   "00 τρισεκατομμύρια",
              ["10000000000000_count_other"] =   "00 τρισεκατομμύρια",
              ["100000000000000_count_one"] =   "000 τρισεκατομμύρια",
              ["100000000000000_count_other"] =   "000 τρισεκατομμύρια"
            }
          },
          short =  {
            decimalFormat =  {
              ["1000_count_one"] =   "0 χιλ'.'",
              ["1000_count_other"] =   "0 χιλ'.'",
              ["10000_count_one"] =   "00 χιλ'.'",
              ["10000_count_other"] =   "00 χιλ'.'",
              ["100000_count_one"] =   "000 χιλ'.'",
              ["100000_count_other"] =   "000 χιλ'.'",
              ["1000000_count_one"] =   "0 εκ'.'",
              ["1000000_count_other"] =   "0 εκ'.'",
              ["10000000_count_one"] =   "00 εκ'.'",
              ["10000000_count_other"] =   "00 εκ'.'",
              ["100000000_count_one"] =   "000 εκ'.'",
              ["100000000_count_other"] =   "000 εκ'.'",
              ["1000000000_count_one"] =   "0 δισ'.'",
              ["1000000000_count_other"] =   "0 δισ'.'",
              ["10000000000_count_one"] =   "00 δισ'.'",
              ["10000000000_count_other"] =   "00 δισ'.'",
              ["100000000000_count_one"] =   "000 δισ'.'",
              ["100000000000_count_other"] =   "000 δισ'.'",
              ["1000000000000_count_one"] =   "0 τρισ'.'",
              ["1000000000000_count_other"] =   "0 τρισ'.'",
              ["10000000000000_count_one"] =   "00 τρισ'.'",
              ["10000000000000_count_other"] =   "00 τρισ'.'",
              ["100000000000000_count_one"] =   "000 τρισ'.'",
              ["100000000000000_count_other"] =   "000 τρισ'.'"
            }
          }
        },
        scientificFormats_numberSystem_latn =  {
          standard =  "#E0"
        },
        percentFormats_numberSystem_latn =  {
          standard =  [[#,##0%]]
        },
        currencyFormats_numberSystem_latn =  {
          currencySpacing =  {
            beforeCurrency =  {
              currencyMatch =  "[=^S=]",
              surroundingMatch =  "[=digit=]",
              insertBetween =  " "
            },
            afterCurrency =  {
              currencyMatch =  "[=^S=]",
              surroundingMatch =  "[=digit=]",
              insertBetween =  " "
            }
          },
          accounting =  "¤#,##0.00;(¤#,##0.00)",
          standard =  "#,##0.00 ¤",
          unitPattern_count_one =  "{0} {1}",
          unitPattern_count_other =  "{0} {1}"
        },
        miscPatterns_numberSystem_latn =  {
          atLeast =  "{0}+",
          range =  "{0}–{1}"
        }
      }
    }
  }
return main
