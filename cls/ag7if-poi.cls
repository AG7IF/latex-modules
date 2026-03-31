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

\DeclareOption{draft}{%
    \newcommand{\@DRAFT}{}
}
\DeclareOption{refs}{%
    \newcommand{\@references}{}
}
\DeclareOption{vhistory}{%
    \newcommand{\vhistory}{}
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

\ifdefined\@references
    \RequirePackage[notes,backend=biber]{biblatex-chicago}
    \addbibresource{references.bib}
\fi

\ifdefined\vhistory
    \RequirePackage[nochapter,tablegrid]{vhistory}
\fi

\RequirePackage{xstring}

\ifdefined\@DRAFT
    \RequirePackage{draftwatermark}
\fi

\pagestyle{usaf}

% Header
% Paragraphs
\renewcommand{\theparagraph}{\arabic{section}.\arabic{subsection}.\arabic{paragraph}}
\titleformat{\paragraph}[runin]{}{\theparagraph}{0.5em}{\underline}

% Commands
\newcommand{\controlNumber}[1]{%
    \def\@controlNumber{#1}
}

\newcommand{\submitter}[1]{%
    \def\@submitter{#1}
}

\newcommand{\submitterOffice}[1]{%
    \def\@submitterOffice{#1}
}

\newcommand{\recorder}[1]{%
    \def\@recorder{#1}
}

\newcommand{\recorderOffice}[1]{%
    \def\@recorderOffice{#1}
}

\newcommand{\authority}[1]{%
    \def\@authority{#1}
}

\newcommand{\certified}[2][ADOPTED]{%
    \def\@certifiedOutcome{#1}
    \def\@certifiedDate{#2}
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

    \ifdefined\vhistory
        \hfill\vhCurrentDate
    \else
        \hfill\@date
    \fi

    \vspace{\baselineskip}
    {\large\textbf{\@controlNumber}}

    \vspace{\baselineskip}

    {\Large\textbf{\@title}}

    \vspace{2\baselineskip}
}

\AtEndDocument{%
\clearpage

\section*{Indorsements}

\ifdefined\vhistory
    \begin{indorsement}{\@submitterOffice}{\vhCurrentDate}{RECORD}{\@submitter}{}{\@submitterOffice}
        Resolved, that version \vhCurrentVersion\ of \@controlNumber\ be adopted IAW\ \@authority.
    \end{indorsement}
\else
    \begin{indorsement}{\@submitterOffice}{\@date}{RECORD}{\@submitter}{}{\@submitterOffice}
        Resolved, that the foregoing draft of\ \@controlNumber\ be adopted IAW\ \@authority.
    \end{indorsement}
\fi


\ifdefined\@certifiedDate
    \begin{indorsement}{\@recorderOffice}{\@certifiedDate}{RECORD}{\@recorder}{}{\@recorderOffice}

        \ifdefined\vhistory
            Version \vhCurrentVersion\ of \@controlNumber\ was \@certifiedOutcome\ on\ \@certifiedDate\ IAW \@authority.
        \else
            The foregoing draft of \@controlNumber\ was \@certifiedOutcome\ on\ \@certifiedDate\ IAW \@authority.
        \fi
    
    \end{indorsement}
\else
    \begin{indorsement}{\@recorderOffice}{\fillinblank}{RECORD}{\@recorder}{}{\@recorderOffice}

        \ifdefined\vhistory
            Version \vhCurrentVersion\ of \@controlNumber\ was

            \vspace{0.5\baselineskip}

            [~ADOPTED~|~REJECTED~|~AS~AMENDED~] \newline

            \vspace{0.5\baselineskip}

            on\ \fillinblank\  IAW \@authority.
        \else
            The foregoing draft of \@controlNumber\ was

            \vspace{0.5\baselineskip}

            [~ADOPTED~|~REJECTED~|~AS~AMENDED~]

            \vspace{0.5\baselineskip}

            on\ \fillinblank\  IAW \@authority.
        \fi

    \end{indorsement}
\fi

\ifdefined\vhistory
    \clearpage
    \section*{Revisions}
    \vhistory
\fi

\ifdefined\@references
    \printbibliography[title={References}]
\fi
}
