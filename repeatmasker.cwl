#!/usr/bin/env cwl-runner

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

$schemas:
- http://dublincore.org/2012/06/14/dcterms.rdf
- http://xmlns.com/foaf/spec/20140114.rdf

cwlVersion: v1.0
id: RepeatMasker
label: RepeatMasker
doc: |
  ![build_status](https://quay.io/repository/biocontainers/repeatmasker/status)
  [RepeatMasker](http://www.repeatmasker.org/) is a program that screens DNA
  sequences for interspersed repeats and low complexity DNA sequences. This
  tool made available via bioconda and the resulting biocontainers container
  image is built from that conda recipe.
class: CommandLineTool

dct:creator:
  "@id": "http://orcid.org/0000-0001-6553-5274"
  foaf:name: Peter van Heusden
  foaf:mbox: "mailto:pvh@sanbi.ac.za"

requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: REPEATMASKER_MATRICES_DIR
        envValue: $(inputs.repeatMaskerDir.path)/Matrices
      - envName: REPEATMASKER_LIB_DIR
        envValue: $(inputs.repeatMaskerDir.path)/Libraries
      - envName: REPEATMASKER_CACHE_DIR
        envValue: /tmp  # make RepeatMasker build its database in /tmp

hints:
  - class: DockerRequirement
    dockerPull: "quay.io/biocontainers/repeatmasker:4.0.7--pl5.22.0_10"

inputs:
  fastaFile:
    type: File
    inputBinding:
      position: 1
  repeatMaskerDir:
    type: Directory
  library:
    type: File?
    inputBinding:
      prefix: "-lib"
  species:
    type: string?
    inputBinding:
      prefix: "-species"
  is_only:
    type: boolean?
    inputBinding:
      prefix: "-is_only"
  is_clip:
    type: boolean?
    inputBinding:
      prefix: "-is_clip"
  no_is:
    type: boolean?
    inputBinding:
      prefix: "-no_is"
  rodspec:
    type: boolean?
    inputBinding:
      prefix: "-rodspec"
  primspec:
    type: boolean?
    inputBinding:
      prefix: "-primspec"
  cutoff:
    type: int?
    inputBinding:
      prefix: "-cutoff"
  nolow:
    type: boolean?
    inputBinding:
      prefix: "-nolow"
  noint:
    type: boolean?
    inputBinding:
      prefix: "-noint"
  norna:
    type: boolean?
    inputBinding:
      prefix: "-norna"
  alu:
    type: boolean?
    inputBinding:
      prefix: "-alu"
  div:
    type: int?
    inputBinding:
      prefix: "-div"
  quick:
    type: boolean?
    inputBinding:
      prefix: "-q"
  quickquick:
    type: boolean?
    inputBinding:
      prefix: "-qq"
  slow:
    type: boolean?
    inputBinding:
      prefix: "-slow"
  parallel:
    type: int?
    inputBinding:
      prefix: "-parallel"
  frag:
    type: int?
    inputBinding:
      prefix: "-frag"
  maxsize:
    type: int?
    inputBinding:
      prefix: "-maxsize"
  gc:
    type: int?
    inputBinding:
      prefix: "-gc"
  gccalc:
    type: boolean?
    inputBinding:
      prefix: "-gccalc"
  nocut:
    type: boolean?
    inputBinding:
      prefix: "-nocut"
  alignments:
    type: boolean?
    inputBinding:
      prefix: "-ali"
  usex:
    type: boolean?
    inputBinding:
      prefix: "-x"
  use_smallx:
    type: boolean?
    inputBinding:
      prefix: "-xsmall"
  poly:
    type: boolean?
    inputBinding:   # TODO: need to see where this output goes
      prefix: "-poly"
  gff:
    type: boolean?
    inputBinding:   # TODO: need to pick up this output
      prefix: "-gff"

baseCommand: [ "RepeatMasker", "-dir", "/var/spool/cwl" ]

# stdout: masked.fasta

outputs:
  maskedFasta:
    type: File
    outputBinding:
      glob: $(inputs.fastaFile.basename).masked
  unprocessedRepeats:
    type: File
    outputBinding:
      glob: $(inputs.fastaFile.basename).cat
  originalOutput:
    type: File
    outputBinding:
      glob: $(inputs.fastaFile.basename).ori.out
  annotation:
    type: File
    outputBinding:
      glob: $(inputs.fastaFile.basename).out
  summaryTable:
    type: File
    outputBinding:
      glob: $(inputs.fastaFile.basename).tbl
  alignmentsOutput:
    type: File?
    outputBinding:
      glob: $(inputs.fastaFile.basename).align
  polymorphicSimpleRepeats:
    type: File?
    outputBinding:
      glob: $(inputs.fastaFile.basename).polyout
