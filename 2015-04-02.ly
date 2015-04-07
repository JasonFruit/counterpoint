\version "2.14.2"

staffSize = 26
sizeFactor = #1.5

#(set! paper-alist (cons '("6x9" . (cons (* 6 in) (* 9 in))) paper-alist))
#(set-global-staff-size (/ staffSize sizeFactor))

\paper  {
  #(set-paper-size "6x9")
  #(define fonts
    (make-pango-font-tree
     "Palatino Linotype" 
     "Palatino Linotype"
     "Libre Baskerville"
     (/ (/ staffSize sizeFactor) 20)))
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

tuneTitle = "Unknown"
tuneMeter = "C.M."
author = ""
voiceFontSize = 0

cantusMusic = {
  \clef alto
  \key g \major
  \autoBeamOff
  \time 4/2
  \relative c' {
    \override Staff.NoteHead.style = #'baroque
    \set Score.tempoHideNote = ##t \tempo 4 = 120
    \override Staff.TimeSignature #'break-visibility = ##(#f #f #f) 
    \set fontSize = \voiceFontSize
    \partial 2 r2 r1 g2 b c d e e, fis g4. a8 b4 b2 a4 g2
    d'2 g fis e d e fis e e fis 
    g2~ g4 fis e2 d2. c4 b1.
    }
}

mediusMusic = {
  \clef "alto"
  \key g \major
  \autoBeamOff
  \time 4/2
  \relative c' {
    \override Staff.NoteHead.style = #'baroque
    \override Staff.TimeSignature #'break-visibility = ##(#f #f #f)
    \set fontSize = \voiceFontSize
    g2 b c d g, a b c \bar "||"
    b2 a g g fis g1. \bar "||"
    d'2 g fis e d d cis d \bar "||"
    b2 a g g fis g1. \bar "|."
  }
}

bassusMusic = {
  \clef bass
  \key g \major
  \autoBeamOff
  \time 4/2
  \relative c' {
    \override Staff.NoteHead.style = #'baroque
    \override Staff.TimeSignature #'break-visibility = ##(#f #f #f) 
    \set fontSize = \voiceFontSize
    g2 g a b g f4 e d2 c 
    g'2 d2 e4 c d2 d g,1. r2
    r2 d'2 g fis g a d,
    g,2 a4. b8 c2 d d g,1.
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
