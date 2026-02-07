\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ag7if-poi}

% Document Setup:
%
% \documentclass[<draft>,<cap>,<mr>,<fouo>]{usaf-memo}
%
% \seal{<SEAL_PATH>} % Optional if using the <cap> document option
% \unitPatch{<UNIT_PATCH_PATH>}
% \unitName{<UNIT>}
% \address{<UNIT_ADDRESS> \\ <CITY>, <STATE> <ZIP>}
%
% \controlNumber{<CONTROL_NUMBER>}
% \title{<SUBJECT>}
% \date{<DATE>}
%
% \begin{document}
% \maketitle
% \end{document}

\DeclareOption{DRAFT}{%
    \newcommand{\@DRAFT}{}
}
\DeclareOption{letter}{%
    \newcommand{\@LETTER}{}
}
\DeclareOption{mfr}{%
    \newcommand{\@MFR}{}
}
\DeclareOption{very-sensitive}{%
    \newcommand{\@MemoInfosecLvlSet}{}
    \newcommand{\@MemoLvlVerySensitive}{}
}
\DeclareOption{sensitive}{%
    \newcommand{\@MemoInfosecLvlSet}{}
    \newcommand{\@MemoLvlSensitive}{}
}
\DeclareOption{somewhat-sensitive}{%
    \newcommand{\@MemoInfosecLvlSet}{}
    \newcommand{\@MemoLvlSomewhatSensitive}{}
}
\DeclareOption{not-sensitive}{%
    \newcommand{\@MemoInfosecLvlSet}{}
    \newcommand{\@MemoLvlNotSensitive}{}
}
\DeclareOption{tlp-red}{%
    \newcommand{\@MemoTlpLvlSet}{}
    \newcommand{\@MemoTlpRed}{}
}
\DeclareOption{tlp-amber-strict}{%
    \newcommand{\@MemoTlpLvlSet}{}
    \newcommand{\@MemoTlpAmberStrict}{}
}
\DeclareOption{tlp-amber}{%
    \newcommand{\@MemoTlpLvlSet}{}
    \newcommand{\@MemoTlpAmber}{}
}
\DeclareOption{tlp-green}{%
    \newcommand{\@MemoTlpLvlSet}{}
    \newcommand{\@MemoTlpGreen}{}
}
\DeclareOption{tlp-clear}{%
    \newcommand{\@MemoTlpLvlSet}{}
    \newcommand{\@MemoTlpClear}{}
}
\ProcessOptions\relax

\LoadClass[12pt]{article}

\RequirePackage{enumerate}
\RequirePackage[
    margin=1in,
    headheight=15pt,
    footskip=0.5in
]{geometry}
\RequirePackage{nth}
\ifdefined\@MemoInfosecLvlSet
    \def\@securityMark{PLACEHOLDER}
    \ifdefined\@MemoTlpLvlSet
        \def\@tlpMark{PLACEHOLDER}
    \fi
    \RequirePackage{usaf-pub}
    \ifdefined\@MemoLvlVerySensitive
        \RequirePackage[very-sensitive]{ag7if-infosec}
    \else\ifdefined\@MemoLvlSensitive
        \RequirePackage[sensitive]{ag7if-infosec}
    \else\ifdefined\@MemoLvlSomewhatSensitive
        \RequirePackage[somewhat-sensitive]{ag7if-infosec}
    \else\ifdefined\@MemoLvlNotSensitive
        \RequirePackage[not-sensitive]{ag7if-infosec}
    \fi\fi\fi\fi
    \ifdefined\@MemoTlpRed
        \RequirePackage[tlp-red]{cert-tlp}
    \else\ifdefined\@MemoTlpAmberStrict
        \RequirePackage[tlp-amber-strict]{cert-tlp}
    \else\ifdefined\@MemoTlpAmber
        \RequirePackage[tlp-amber]{cert-tlp}
    \else\ifdefined\@MemoTlpGreen
        \RequirePackage[tlp-green]{cert-tlp}
    \else\ifdefined\@MemoTlpClear
        \RequirePackage[tlp-clear]{cert-tlp}
    \fi\fi\fi\fi\fi
    \def\@securityMark{\InfosecLevel}
    \ifdefined\@MemoTlpLvlSet
        \def\@tlpMark{\TLPLevel}
    \fi
\else
    \RequirePackage{usaf-pub}
\fi
\RequirePackage{xstring}
\ifdefined\@DRAFT
    \RequirePackage{draftwatermark}
\fi

\pagestyle{usaf}

% Header
% Paragraphs
\renewcommand{\theparagraph}{\makebox[3ex][l]{\arabic{section}.\arabic{subsection}.\arabic{paragraph}.}}
\titleformat{\paragraph}[runin]{}{\theparagraph}{1em}{\underline}

% Commands
\newcommand{\controlNumber}[1]{%
    \def\@controlNumber{#1}
}

\renewcommand{\date}[1]{%
    \def\@date{#1}
}

\renewcommand{\maketitle}{%
    \thispagestyle{letterhead}

    \ifdefined\@MemoInfosecLvlSet
        \vspace*{0.75in}
    \else
        \vspace*{0.5in}
    \fi

    %\hfill\@controlNumber

    \hfill\@date

    \vspace{\baselineskip}
    {\large\textbf{\@controlNumber}}

    \vspace{\baselineskip}

    {\Large\textbf{\@title}}

    \vspace{2\baselineskip}
}
