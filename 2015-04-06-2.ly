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

tuneTitle = ""
tuneMeter = "C.M."
author = ""
voiceFontSize = 0

cantusMusic = {
  \clef treble
  \key g \major
  \autoBeamOff

  \relative c'' {
    \override Staff.NoteHead.style = #'baroque
    \set Score.tempoHideNote = ##t \tempo 4 = 120
    \override Staff.TimeSignature #'break-visibility = ##(#f #f #f) 
    \set fontSize = \voiceFontSize
    r1 r4 d fis, g c4. d8 c4 b a c e, fis g4. g8 a4 b
    c4. a8 b4 c d2. c8[ b] a8.[ g16] fis4. e8 fis g fis4. d8 e4 fis
    g4. fis8 g4 a b4. g8 a4 b c4. b16[ c] d2~ d8[ c16 b] c4. b8[ a g] a2~ a8[ fis g a]
    g8[ d e fis] g[ g a b] c[ a b c] d[ b c d] e[ d c b] a[ d16 c b8 a] g\breve % d[ g, a b] a[ g a b]  a8[ d16 c b8 a] g\breve
    }
}

bassusMusic = {
  \clef alto
  \key g \major
  \autoBeamOff
  \relative c' {
    \override Staff.NoteHead.style = #'baroque
    \override Staff.TimeSignature #'break-visibility = ##(#f #f #f) 
    \set fontSize = \voiceFontSize
      \time 10/2 g1 b2. b4 a2 g c c b1
      \time 8/2 a1 b2 d d cis d1
      \time 10/2 b1 e2 d c b a g fis1
      \time 10/2 b1 a2 g g fis g\breve \bar "|."
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
	\new Staff = "bassus" {
	  <<
	    \new  Voice = "four" { \stemDown \slurDown \tieDown \bassusMusic }
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
