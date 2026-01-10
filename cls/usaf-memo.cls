\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{usaf-memo}

% Document Setup:
%
% \documentclass[<draft>,<cap>,<mr>,<fouo>]{usaf-memo}
%
% \seal{<SEAL_PATH>} % Optional if using the <cap> document option
% \unitPatch{<UNIT_PATCH_PATH>}
% \unit{<UNIT>}
% \address{<UNIT_ADDRESS> \\ <CITY>, <STATE> <ZIP>}
%
% \memofor{<MEMO_FOR_LINE>} % Ignored if using the <mr> document option
% \memofrom{<MEMO_FROM_LINE>}
% \subject{<SUBJECT>}
%
% \begin{document}
% \maketitle
%
% \paragraph{} <CONTENT>
%
% \paragraph{} <CONTENT>
%
% \signature{<NAME>}{<GRADE>}{<DUTY_ASSIGNMENT>} % For hand-signing after printing
% \textsign{<NAME>}{<GRADE>}{<DUTY_ASSIGNMENT>} % Inserts "// SIGNED //" above the signature block
% \digisign{<NAME>}{<GRADE>}{<DUTY_ASSIGNMENT>}{<SIG_IMG_PATH>} % For including an image of the signature
%
% \attachment{<ATTACHMENT>} % For a single attachment
% \attachments{%
%   \item <ATTACHMENT_1>
%   \item <ATTACHMENT_2>
% } % For multiple attachments
%
% \cc{%
%   <CC_TO_1> \\
%   <CC_TO_2>
% }
%
% \distribution{%
%   <DIST_TO_1> \\
%   <DIST_TO_2>
% }
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
\newcounter{memopar}
\renewcommand{\thememopar}{\arabic{memopar}.}
\newenvironment{body}{
    \setlength{\parindent}{0pt}
    \setcounter{memopar}{0}
    \bigskip
    \renewcommand{\item}{
        \par
        \refstepcounter{memopar}
        \makebox[2ex][l]{\thememopar}
    }
}{
    \bigskip
    \noindent
    \ignorespacesafterend
}

% Commands
\newcommand{\controlNumber}[1]{%
    \def\@controlNumber{#1}
}

\renewcommand{\date}[1]{%
    \def\@date{#1}
}

\newcommand{\salutation}[1]{%
    \def\@salutation{#1}
}

\renewcommand{\maketitle}{%
    \thispagestyle{letterhead}

    \ifdefined\@MemoInfosecLvlSet
        \vspace*{0.75in}
    \else
        \vspace*{0.5in}
    \fi
    \ifdefined\@controlNumber
        \hfill\@controlNumber
    \fi

    \hfill\@date

    \ifdefined\@LETTER
        \vspace{3\baselineskip}
        \ifdefined\@memofrom
            \@memofrom
            \vspace{2\baselineskip}
        \fi
        \@memofor

        \vspace{\baselineskip}
        \@salutation

        \vspace{\baselineskip}
    \else
        \vspace{\baselineskip}
        MEMORANDUM FOR\hspace{0.25em}
        \ifdefined\@MFR
            RECORD
        \else
            \begin{minipage}[t]{0.75\textwidth}
            \MakeUppercase{\@memofor}
            \end{minipage}
        \fi

        \ifdefined\@MFR\else
            \vspace{\baselineskip}
            FROM:\hspace{0.25em}
            \begin{minipage}[t]{0.75\textwidth}
            \@memofrom
            \end{minipage}
        \fi

        \vspace{\baselineskip}
        SUBJECT:~ \@subject
    \fi
}

\newcommand{\memofor}[1]{%
    \def\@memofor{#1}
}

\newcommand{\memofrom}[1]{%
    \def\@memofrom{#1}
}

\newcommand{\subject}[1]{%
    \def\@subject{#1}
}
