{
  en: {
    date: {
      formats: {
        dmy_with_full_words: lambda { |time,_| "#{time.day.ordinalize} %B %Y"},
        day_dmy_with_full_words: lambda { |time,_| "%A, #{time.day.ordinalize} %B %Y"}
      }
    },
    time: {
      formats: {
        dmy_with_full_words: lambda { |time,_| "#{time.day.ordinalize} %B %Y"},
        day_dmy_with_full_words: lambda { |time,_| "%A, #{time.day.ordinalize} %B %Y"}
      }
    }
  }
}
