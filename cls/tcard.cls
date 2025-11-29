\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tcard}

\newlength{\headerheight}
\newlength{\headerwidth}
\newlength{\bodyheight}
\newlength{\bodywidth}

\DeclareOption{no2}{%
    \def\@sizeTwo{}
    \setlength{\headerheight}{0.625in}
    \setlength{\headerwidth}{2.375in}
    \setlength{\bodyheight}{2.75in}
    \setlength{\bodywidth}{1.875in}
}

\DeclareOption{no3}{%
    \def\@sizeThree{}
    \setlength{\headerheight}{0.625in}
    \setlength{\headerwidth}{3.625in}
    \setlength{\bodyheight}{4.125in}
    \setlength{\bodywidth}{3.125in}
}

\DeclareOption{no4}{%
    \def\@sizeFour{}
    \setlength{\headerheight}{0.625in}
    \setlength{\headerwidth}{4.875in}
    \setlength{\bodyheight}{6.5in}
    \setlength{\bodywidth}{4.375in}
}
\ProcessOptions\relax

\LoadClass[10pt]{article}

\setlength{\fboxsep}{0pt}
\setlength{\headheight}{0pt}
\setlength{\parindent}{0pt}

\ifdefined\@sizeTwo
    \RequirePackage[
        paperwidth=3.5in,
        paperheight=4.5in,
        top=0.25in,
        bottom=0.1in,
        left=0.5in,
        right=0.1in
    ]{geometry}
\else\ifdefined\@sizeThree
    \RequirePackage[
        paperwidth=4.5in,
        paperheight=6.0in,
        top=0.5in,
        bottom=0.1in,
        left=0.5in,
        right=0.1in
    ]{geometry}
\else\ifdefined\@sizeFour
    \RequirePackage[
        paperwidth=6.0in,
        paperheight=8.0in,
        top=0.5in,
        bottom=0.1in,
        left=0.5in,
        right=0.1in
    ]{geometry}
\else
   \ClassWarning{tcard}{tcard class declared without a T-Card size, Geometry not loaded} 
\fi\fi\fi

\RequirePackage{ag7if-form}
\RequirePackage{fancyhdr}
\RequirePackage{stackengine}

\renewcommand{\headrulewidth}{0pt}

\fancypagestyle{tcard}{%
    \fancyhf{}
}

\pagestyle{tcard}

\newcommand{\controlNumber}[1]{%
    \def\@controlNumber{#1}%
}

\newcommand{\revision}[1]{%
    \def\@revision{#1}%
}

\newcommand{\drawCard}[2]{%
\stackunder[-\fboxrule]{%
    \framebox[3.625in]{\parbox[t][0.625in]{3.5in}{#1}}%
}{%
    \framebox[3.125in]{\parbox[t][4.125in]{3in}{#2}}
}
}
