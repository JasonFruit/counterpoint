\version "2.14.2"

staffSize = 26
sizeFactor = #1.5

#(set! paper-alist (cons '("6x9" . (cons (* 6 in) (* 9 in))) paper-alist))
#(set-global-staff-size (/ staffSize sizeFactor))

\paper  {
  #(set-paper-size "6x9")
  print-all-headers = ##t
  print-page-number = ##t
  top-margin = 0.5 \in
  left-margin = 0.75 \in
  right-margin = 0.25 \in
  bottom-margin = 0.5 \in
}

\header {
  tagline = ""
}

tuneTitle = "Martyrs"
tuneMeter = "C.M."
author = ""
voiceFontSize = 0

cantusMusic = {
  \clef treble
  \key e \minor
  \autoBeamOff
  \relative c'' {
    \override Staff.NoteHead.style = #'baroque
    \set Score.tempoHideNote = ##t \tempo 4 = 120
    \override Staff.TimeSignature #'break-visibility = ##(#f #f #f) 
    \set fontSize = \voiceFontSize
      \time 12/2
      b2 b2.( a4) g2 g( fis) e1 dis2 e fis1
      \time 9/2
      b2 b2.( a4) g( fis) e2.( fis4) g( a) b1
      \time 12/2
      d2 b1 cis2 d( c) b1 a2 g fis1
      \time 11/2 b2 a2.( g4) fis2 e1 dis2 e\breve \bar "||"
      
      \time 12/2 e4.( fis8) g1 e2 b'1 g2 fis1 e2 b'1
      \time 9/2 b2 d1 b2 cis1 e2 b1
      \time 12/2 b2 d1 a2 b( a) g fis1 e2 b'1
      \time 11/2 d2 cis2.( b4) a4.( b8) cis!4( b8[ a]) b1 e,\breve \bar "||"
      
      \time 12/2 e4.( fis8) g1 e2 b'1 g2 fis1 e2 b'1
      \time 9/2 r2 fis a2. g2 fis4 e2. g4 fis1
      \time 12/2 b2 d1 a2 b( a) g fis1 e2 b'1
      \time 11/2 d2 cis2.( b4) a4.( b8) cis4( b8[ a]) b1 e,\breve \bar "||"
    }
}

mediusMusic = {
  \clef "treble_8"
  \key e \minor
  \autoBeamOff
  \relative c {
    \override Staff.NoteHead.style = #'baroque
    \override Staff.TimeSignature #'break-visibility = ##(#f #f #f)
    \set fontSize = \voiceFontSize
    e4.( fis8) g1 e2 b'1 g2 fis1 e2 b'1
    b2 d1 b2 cis1 e2 b1
    b2 d1 a2 b( a) g fis1 e2 b'1
    d2 cis2.( b4) a4.( b8) cis4( b8[ a]) b1 e,\breve
    
    g4.( fis8) e2( b') e d1 c4( b) a2.( b4) c2 b1
    b4.( a8) g2( d') g4.( fis8) e2 a,2.( g8[ a]) b1
    b4.( a8) g2. a2( g8[ fis]) e2 c'( b) a4.( g8 a4 b) c2 b1
    g2 a2.( b4) c!4.( b8) a2. g2( fis4) e\breve
    
    r2 e4.( fis8) g1 e2 b'1 a2 g2. fis4 e1
    b'2 d1 b2 cis1 e2 b1
    r1 b2 d1 a2 b( a) g2. fis4 e1
    b'2 e d c4.( b8) a2. g2 fis4 e\breve
  }
}

\score
{
  \header {
    poet = \markup { \typewriter { \author } }
    instrument = \markup { \typewriter { #(string-append tuneTitle ". ") }
			   \tuneMeter }
    tagline = ""
  }

  <<
    \new StaffGroup {
      <<
        \new Staff = "cantus" {
          <<
            \new Voice = "one" { \stemUp \slurUp \tieUp \cantusMusic }
          >>
        }
        \new Staff = "medius" {
          <<
            \new Voice = "two" { \stemDown \slurDown \tieDown \mediusMusic }
          >>
        }
      >>
    }
    
  >>

  \layout {
    \context {
      \override VerticalAxisGroup #'minimum-Y-extent = #'(0 . 0)
    }
    \context {
      \Lyrics
      \override LyricText #'font-size = #-1
    }
    \context {
      \Score
      \remove "Bar_number_engraver"
    }
    indent = 0 \cm
  }
  \midi { }
}
