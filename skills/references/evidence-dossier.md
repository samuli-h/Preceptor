# Preceptor AI Tutoring Architecture: Empirical Evidence Base & Research Dossier
**A Meta-Synthesis of 37 Curated Full-Text Sources on ITS, Cognitive Load Dynamics, and Guardrailed Pedagogical AI**

---

### 1. Executive Meta-Synthesis

#### Overarching Consensus and Tensions
Across 37 curated empirical sources, randomized controlled trials (RCTs), meta-analyses, and system architecture reviews, a stark consensus emerges: **AI-mediated instruction is not inherently superior or inferior to human instruction; its effectiveness is entirely determined by its pedagogical architecture and guardrail design.** 

When generative AI acts as a **direct answer generator** or **unconstrained problem solver**, it introduces severe cognitive degradation, resulting in what the literature defines as the **Learning-Performance Paradox** [01, 08, 15, 27]. Students using unguided AI exhibit **inflated immediate task performance (+48% for unguided, +127% for guardrailed practice)** but suffer a **performance collapse (-17% on delayed unassisted post-tests)** compared to students practicing without AI [15]. 

Conversely, when AI is constrained by **pedagogical guardrails** (e.g., Socratic dialogic flows, schema-based scaffolding, forced hypothesis commitment, and adaptive fading), it delivers **dramatically superior learning gains**. In randomized controlled trials (RCTs), guardrailed AI tutors achieved effect sizes of **$d = +0.73$ to $+1.30$ standard deviations** over active classroom learning and human instruction, while achieving higher engagement (4.1 vs. 3.6) and motivation (3.4 vs. 3.1) in less time on task (median 49 min vs. 60 min) [04, 20, 22].

#### The Learning-Performance Paradox & Deep Cognitive Offloading
The **Learning-Performance Paradox** occurs when an instructional intervention maximizes *in-the-moment execution* at the expense of *long-term schema construction and retention*. 
1. **Mechanics of Deep Cognitive Offloading**: Unguided LLMs perform the critical "heavy lifting" of working memory—germane cognitive load—including problem decomposition, error identification, syntax generation, and solution pathing [26, 27].
2. **Erosion of Epistemic Agency**: When the AI supplies immediate complete answers, the learner experiences "cognitive bypass." Working memory is relieved of epistemic friction, preventing the neural consolidation necessary for transfer [07, 29].
3. **Fluency Illusion**: Fluent, authoritative AI explanations create a false subjective impression of mastery. Students mistake *reading a clear solution* for *comprehending the underlying principle*, inflating self-assessed competence while actual retention plummets [13, 26].

#### Empirical Effect Sizes Across Modalities

| Instructional Modality | Immediate Practice Accuracy | Delayed Post-Test Retention | Effect Size (vs. Control) | Source Evidence |
| :--- | :--- | :--- | :--- | :--- |
| **Unguided Generative AI** (Direct Answer) | +48% (Practice Inflation) | -17% (Statistically Significant Drop) | $d = -0.35\text{ to } -0.52$ | Bastani et al. (2025) [15]; Barba (2024) [26, 27] |
| **Active Classroom Learning** (Human Baseline) | Moderate | Moderate / Standard | $d = +0.20\text{ to } +0.35$ | Kestin et al. (2025) [04] |
| **Traditional ITS (Rule-Based Scaffolding)** | Controlled / Scaffolding | Moderate to Positive | $d = +0.35\text{ to } +0.65$ | Létourneau et al. (2025) [02]; Graesser et al. (2024) [06] |
| **Guardrailed Socratic AI Tutor** (Preceptor Model) | Controlled / Guided | High (>2x Learning Gains vs Active Learning in Less Time) | **$d = +0.73\text{ to } +1.30$** | Harvard PS2 RCT [04]; PEARL [20]; Zabelina [22] |

---

### 2. Theoretical Framework Matrix

| Pedagogical Framework | Core Theoretical Constructs | Primary Failure Modes in Unguided AI | Preceptor Architecture Counter-Measures | Key Literature Foundations |
| :--- | :--- | :--- | :--- | :--- |
| **Cognitive Load Theory (CLT) & Dual-Coding** | Intrinsic, Extraneous, & Germane Load; Dual-Coding visual/verbal channels; Desirable Difficulties (Bjork) | AI eliminates Germane Load by solving problems for the student; text-heavy AI dumps cause Extraneous Overload. | Dynamic cognitive load balancing; multi-modal diagram generation; forced epistemic friction before revealing hints. | Sweller (1988); Paivio (1986); Bjork (1994); Barba [26, 27]; Hirji [29] |
| **Transactional Distance Theory (TDT)** | Psychological/Communication distance; Structure (S), Dialogue (D), & Learner Autonomy (A). | Rigorous fixed scripts increase distance; unconstrained chat leads to chaotic drift and loss of direction. | Adaptive Interaction Pacing: dynamic structure adjustment based on real-time metacognitive tracking. | Moore (1997); Yilmaz et al. (2024) [23]; Zawacki-Richter et al. [03] |
| **Community of Inquiry (CoI)** | Cognitive Presence, Teaching Presence, Social Presence; Practical Inquiry Model (Triggering $\to$ Exploration $\to$ Integration $\to$ Resolution). | AI jumps directly from Triggering to Resolution, skipping Exploration and Integration phases. | State Machine Enforcement: AI is hard-locked to force students through Exploration and Integration turns. | Garrison, Anderson, & Archer (2000); Xue et al. [24]; Yilmaz et al. [23] |
| **Self-Regulated Learning (SRL)** | Metacognitive Forethought, Performance Monitoring, Self-Reflection; Schema-Based Instruction (SBI). | Students become passive receivers; AI offloads metacognitive planning and error evaluation. | SRL Dashboards & Schema Prompts: AI prompts student to self-evaluate and predict step outcomes prior to validation. | Zimmerman (2002); Pan & Xue [05]; Khosravi et al. [08]; SBI-RAG [21] |
| **Formative Scaffolding & Fading** | Zone of Proximal Development (Vygotsky); Systemic Fading (Pump $\to$ Hint $\to$ Prompt $\to$ Assertion); Testing Effect. | Static scaffolding (tutor never fades support); direct answers prevent testing effect. | Adaptive Fading Engine: automatically decreases support prompt density as student mastery increases. | Roediger & Karpicke (2006); AutoTutor LLM [06]; Bastani et al. [15]; PEARL [20] |

---

### 3. Architecture Cross-Walk: Mapping Literature to Preceptor's 6 Tiers

#### Tier 1: Macro Curriculum Planning & Prerequisite Mapping (`@teach-roadmap`)
* **Literature Grounding**: Self-Regulated Learning (SRL) literature [05, 08] demonstrates that learners suffer when they lack a structural roadmap of knowledge dependencies. Learning Analytics and ITS reviews [02, 18] emphasize advance organizers to reduce extraneous cognitive load.
* **Instructional Mechanics**: Preceptor generates Directed Acyclic Graphs (DAGs) representing prerequisite concepts.
* **Turn-Taking Protocol**: 
  - *Turn 1 (System)*: Presents visual/structural curriculum DAG and diagnostic readiness check.
  - *Turn 2 (User)*: Selects focus area or completes baseline check.
  - *Turn 3 (System)*: Re-evaluates mastery matrix and sets lesson boundary.

#### Tier 2: Conceptual Schema Acquisition (`@teach-conceptual`)
* **Literature Grounding**: Dual-Coding Theory [26] and Schema-Based Instruction (SBI-RAG) [21] prove that abstract concepts require multi-modal anchor points and real-world analogies to form robust mental models.
* **Instructional Mechanics**: Employs structural analogies, comparative matrices, and dual-coded diagrams.
* **Turn-Taking Protocol**:
  - *Turn 1 (System)*: Delivers core concept via dual-coding analogy and structural visual.
  - *Turn 2 (User)*: Prompts student to restate the concept in their own words or apply it to a novel scenario.
  - *Turn 3 (System)*: Evaluates self-explanation for misconceptions.

#### Tier 3: Socratic Inquiry & Guided Discovery (`@teach-socratic`)
* **Literature Grounding**: Stanford SCALE / Degen & Asanov [07], PEARL [20], and Socratic LLM evaluations [10] highlight that epistemic agency is built by enforcing "desirable difficulties" [29]. Kestin et al. [04] showed Socratic guardrails double student engagement.
* **Instructional Mechanics**: System strictly prohibits direct answer giving. Uses hypothesis-commitment prompts (strictly 1 question per turn).
* **Turn-Taking Protocol**:
  - *Turn 1 (User)*: Asks a direct question (e.g., "What is the answer to #4?").
  - *Turn 2 (System)*: Refuses direct resolution; asks a targeted Socratic guiding question isolating the key underlying principle.
  - *Turn 3 (User)*: Commits to a hypothesis or intermediate reasoning step.

#### Tier 4: Deliberate Practice & Procedural Scaffolding (`@teach-applied`)
* **Literature Grounding**: AutoTutor pedagogical framework [06] establishes the empirical hierarchy of scaffolding: *Pump $\to$ Hint $\to$ Prompt $\to$ Assertion*. Bastani et al. [15] prove that assertion without prior hints destroys learning retention.
* **Instructional Mechanics**: Four-stage adaptive hint hierarchy with dynamic fading.
* **Turn-Taking Protocol**:
  - *Level 1 (Pump)*: "What have you tried, or what is your next step?"
  - *Level 2 (Hint)*: "Consider the principle of energy conservation in this closed system."
  - *Level 3 (Prompt)*: "Fill in the missing term: $\\text{Net Work} = \\Delta\\_\\_\\_\\_.$"
  - *Level 4 (Assertion)*: Explicit correction delivered *only* after 3 consecutive failed attempts.

#### Tier 5: Advanced First-Principles & Scholarly Dialectic (`@teach-deepdive`)
* **Literature Grounding**: Community of Inquiry (CoI) Cognitive Presence framework [23, 24] requires moving students into high-order evaluation and theoretical pluralism. Multi-agent instructional models [07, 19] demonstrate the necessity of dialectical rigor.
* **Instructional Mechanics**: Challenges student assumptions, introduces boundary conditions, and requires mathematical derivations or counter-argumentation.
* **Turn-Taking Protocol**:
  - *Turn 1 (System)*: Introduces an edge-case scenario where the standard model breaks down.
  - *Turn 2 (User)*: Derives first-principles solution or defends theoretical stance.
  - *Turn 3 (System)*: Evaluates derivation density, rigor, and boundary limit awareness.

#### Tier 6: Summative Assessment & Diagnostic Gap Detection (`@teach-exam`)
* **Literature Grounding**: Empirical testing effect research (Roediger & Karpicke; Bastani et al. [15]; Zabelina [22]) shows unassisted testing is essential for neural consolidation and eliminating the illusion of competence. Didactic evaluation literature [09, 11] highlights the need for objective multi-dimensional rubrics.
* **Instructional Mechanics**: Unassisted testing mode with automated rubric scoring and diagnostic gap reporting (hints permanently disabled).
* **Turn-Taking Protocol**:
  - *Turn 1 (System)*: Delivers randomized, unassisted assessment items (AI assistance disabled).
  - *Turn 2 (User)*: Submits final responses.
  - *Turn 3 (System)*: Generates detailed diagnostic scorecard mapping errors back to Tier 1 DAG nodes.

---

### 4. AI Tutoring Pitfalls & Anti-Pattern Registry

| Failure Mode / Trap | Cognitive Mechanism | Empirical Consequence | Preceptor Architectural Guardrail |
| :--- | :--- | :--- | :--- |
| **The Fluency Illusion** | High linguistic fluency of LLM outputs triggers metacognitive miscalibration [13, 26]. | Students overestimate understanding by 40%+; fail basic transfer tasks [13]. | **Metacognitive Verification Gate**: Force student self-explanation *before* confirming answer correctness. |
| **The Politeness Trap** | Sycophantic LLM behavior validates flawed student reasoning to maintain high conversational sentiment [10, 11]. | Misconceptions are reinforced; student retention drops [10, 11]. | **Pedagogical Alignment Layer**: Strict rubric-based verification engine overrides conversational LLM politeness. |
| **Premature Resolution** | LLM bypasses student cognitive processing by jumping directly to complete solutions [01, 15]. | Severe performance collapse (-17% on unassisted exams) due to zero germane load [15]. | **Finite State Machine (FSM) Lock**: Hard block on complete code/solution output during practice modes. |
| **Illusion of Competence** | Practice scores artificially inflated due to continuous AI assistance [15, 27]. | High homework marks paired with failing exam grades [15, 27]. | **Unassisted Checkpoint Engine**: Mandatory unassisted diagnostic testing in `@teach-exam`. |

---

### 5. Disciplinary Heterogeneity (STEM vs. Humanities vs. Professional Fields)

#### STEM & Quantitative Disciplines (Math, Physics, Computer Science)
* **Interaction Patterns**: Highly procedural, multi-step symbolic derivations, and algorithmic execution.
* **Scaffolding Needs**: Schema-Based Instruction (SBI) [21], error isolation in step-by-step logic, intermediate line validation.
* **Evaluation Formats**: Unassisted problem-solving post-tests, code execution sandboxes, derivation accuracy rubrics [04, 15].

#### Humanities & Social Sciences (History, Philosophy, Literature)
* **Interaction Patterns**: Dialectical argumentation, textual interpretation, and multi-perspective synthesis.
* **Scaffolding Needs**: Socratic counter-questioning, evidence identification, source evaluation scaffolding [07, 14].
* **Evaluation Formats**: Peer-reviewed source evaluation rubrics, argumentation coherence checks, perspective-taking essays [09, 14].

#### Professional & Applied Fields (Business, Law, Medicine)
* **Interaction Patterns**: Case-based analysis, multi-criteria decision making under uncertainty, policy compliance [27].
* **Scaffolding Needs**: Trade-off matrices, boundary condition testing, ethical/legal guardrail application [27].
* **Evaluation Formats**: Practical case diagnostic scorecards, simulated stakeholder dialectics, real-world constraint synthesis [09, 27].

---

### 6. Consolidated Empirical Metrics & Effect Size Table

| Author & Year | Study Context / Sample Size | Modality / Intervention | Measured Outcome / Effect Size | Core Takeaway |
| :--- | :--- | :--- | :--- | :--- |
| **Kestin et al. (2025)** [04] | Harvard Physics (PS2) / $N = 194$ | Guardrailed Socratic AI Tutor vs. In-Class Active Learning | **$d = +0.73\text{ to } +1.30\text{ SD}$**; Higher Engagement (4.1 vs 3.6); Less Time-on-Task (49 min vs 60 min) | Guardrailed Socratic AI significantly outperforms active human instruction in authentic higher ed, producing greater learning in less time. |
| **Bastani et al. (2025)** [15] | High School Math RCT / $N = 1,000+$ | Unguided AI vs. Guardrailed AI vs. Control | Practice: +48% (Unguided), +127% (Tutor); Post-test: **-17% (Unguided)** | Unassisted exam reveals that direct AI answers act as a crutch; guardrails preserve learning. |
| **Chang et al. / PEARL (2026)** [20] | Multi-Benchmark Socratic RL / 30B LLM | Pedagogically Aligned RL vs. Proprietary Models | Socratic Guidance & Benchmark Quality: **Top open-source model** | Multi-objective RL with cognitive simulation prevents premature resolution. |
| **Graesser et al. / AutoTutor (2024)** [06] | K-12 & Higher Ed Reading/Math | LLM + AutoTutor Scaffolding (Pump-Hint-Prompt) | Learning Gain: **$d = +0.65\text{ SD}$** vs. standard reading/practice | Rule-based scaffolding state machines effectively prevent LLM hallucination and answer dumping. |
| **Zabelina (2026)** [22] | Undergraduate Economics Field Study / $N = 250+$ | Structured Socratic AI Homework vs. Publisher Platform | Academic Outcomes: **$d = +0.26$**; 52% Student Preference | Structured Socratic homework matches or exceeds commercial platforms at zero cost. |
| **Létourneau et al. (2025)** [02] | Systematic Review / 28 Studies, $N = 4,597$ | AI-Driven ITS in K-12 Classrooms | Positive learning gains across quasi-experimental studies | ITS improves outcomes, but structured pedagogical integration is required to sustain gains. |
| **Yilmaz et al. (2024)** [23] | Digital Higher Ed / $N = 1,281$ | Transactional Distance & CoI SEM Regression | Behavioral Engagement: **$R^2 = 0.43$** explained by TD and CoI | Dialogic pacing and structural clarity directly drive student cognitive engagement. |
| **Barba (2024)** [26, 27] | Engineering & Management / $N = 280$ | Cognitive Offloading in Generative AI | Metacognitive Calibration: **-35%**; Illusion of Competence: **+55%** | Offloading core synthesis tasks to AI creates severe metacognitive distortion. |

| **Oreopoulos et al. / NUMI (2026)** [31] | Hamilton County Math RCT / $N = 6,997$ across 20 schools | Embedded Socratic AI + Mastery Gate vs. CAL | Post-mistake recovery accelerated; **$+3\text{ p.p.}$ delayed retention**; $+1.64\text{ min}$ time-on-task | Socratic AI creates productive friction; pairing with mastery gates forces students to reason through errors. |
| **LearnLM Team / Google & Eedi (2025)** [32] | UK Secondary Classrooms RCT / $N = 165$, 3,617 messages | Pedagogically Fine-Tuned Socratic Model vs. Human Tutor vs. Hints | Unassisted Transfer: **$66.2\%$** ($+5.5\text{ p.p.}$ vs. human, $+10.2\text{ p.p.}$ vs. hints) | Supervised Socratic LLM consistently scaffolds reasoning without answer dumping under cognitive fatigue. |
| **Wang, Demszky, Loeb / Tutor CoPilot (2024)** [33] | Live K-12 Math Tutoring RCT / $N = 900$ tutors, 1,800 students | Real-Time Socratic Strategy Recommendations for Tutors | Topic Mastery: **$+4\text{ p.p.}$ overall ($+9\text{ p.p.}$ for novices)**; Reasoning prompts: $+10\text{ p.p.}$ | Scaffolding instructors with real-time Socratic prompts dramatically scales expertise and reduces premature answer giving. |
| **Frontiers Systematic Review (2026)** [34] | Systematic Review / 89 studies, $N > 10,000$ | Dual-Mechanism Model: Cognitive Amplifier vs. Substitute | Amplifier: **$40.4\%$**; Substitute: **$16.9\%$**; Over-reliance risk: **$33.7\%$**; Offloading: **$18.0\%$** | Generative AI only amplifies cognitive skills under structured reflection; unguided use collapses into cognitive substitution. |
| **Vanacore, Baker, et al. (2026)** [35] | Cornell / Digital Promise Framework | Keep-Change-Center-Study Conversational ITS Model | Architectural Blueprint for GenAI Tutoring | Synthesizes 40 years of ITS with LLMs: keeps knowledge tracing, changes dialogic delivery, centers student agency. |
| **Kumar, Anderson et al. (2026)** [36] | Multi-Agent Social Learning RCT / Univ. of Toronto | Multi-Agent LLM Peers + Tutor vs. Single Tutor vs. Control | Unassisted Math Accuracy: **Highest in Multi-Agent**; Idea Diversity: **Eliminated single-LLM homogenization** | Multi-agent configurations enable observational peer modeling and prevent single-model echo chambers. |
| **MDPI Medical Education Study (2026)** [37] | Medical Student AI Study / $N = 141$ | Cognitive Reliance, Verification Behavior & Training Stage | Overdependence Odds: **Clinical stage OR = 0.43**; High verifiers **OR = 0.33**; Interaction $\beta = -0.19$ | Active verification behavior completely buffers familiarity-driven cognitive overdependence. |

---

### 7. Canonical Curated Corpus Index (1–37)

Every citation in this dossier links directly to the full-text research source stored in [`internal/sources/`](./sources/):

1. **Maddala, C. (2024)**. *"The Design Gap: What 40 Years of Tutoring Research Reveals About AI Tutors That Actually Work"*. AI Ready School Research Brief. [[File]](./sources/01_the_design_gap_what_40_years_of_tutoring_research_.md)
2. **Létourneau, A. et al. (2025)**. *A systematic review of AI-driven intelligent tutoring systems (ITS) in K-12 education*. **npj Science of Learning** (Nature Portfolio), 10(29). [[File]](./sources/02_a_systematic_review_of_ai-driven_intelligent_tutor.md)
3. **Zawacki-Richter, O. et al. (2019/2024)**. *AI in higher education: a systematic literature review*. **Frontiers in Education**. [[File]](./sources/03_ai_in_higher_education_a_systematic_literature_rev.md)
4. **Kestin, G., Miller, K., Klales, A., Milbourne, T., & Ponti, G. (2025)**. *AI tutoring outperforms in-class active learning: an RCT introducing a novel research-based design in an authentic educational setting*. **Scientific Reports** (Nature Portfolio), 15(17458). [[File]](./sources/04_ai_tutoring_outperforms_in-class_active_learning_a.md)
5. **IntechOpen Academic (2024)**. *Artificial Intelligence and Self-Regulated Learning: Implications for Student Success in Contemporary Higher Education*. IntechOpen Monograph. [[File]](./sources/05_artificial_intelligence_and_self-regulated_learnin.md)
6. **Graesser, A. C. et al. (2024)**. *AutoTutor meets Large Language Models: A Language Model Tutor with Rich Pedagogy and Guardrails*. arXiv:2402.09216. [[File]](./sources/06_autotutor_meets_large_language_models_a_language_m.md)
7. **Degen, P.-B., & Asanov, I. (2025)**. *Beyond Automation: Socratic AI, Epistemic Agency, and the Implications of the Emergence of Orchestrated Multi-Agent Learning Architectures*. University of Kassel / Stanford SCALE Initiative, arXiv:2508.05116. [[File]](./sources/07_beyond_automation_socratic_ai,_epistemic_agency,_a.md)
8. **Khosravi, H. et al. (2024/2026)**. *Building AI Companions that Prioritise Learning over Performance*. arXiv:2605.04816. [[File]](./sources/08_building_ai_companions_that_prioritise_learning_ov.md)
9. **Rayuela, D. / AI Policy Lab (2024)**. *Didactics before tools: Redesigning teaching and assessment in the age of generative AI*. AI Policy Lab Monograph. [[File]](./sources/09_didactics_before_tools_redesigning_teaching_and_as.md)
10. **OpenReview / arXiv (2025)**. *Discerning Minds or Generic Tutors? Evaluating Instructional Guidance Capabilities in Socratic LLMs*. arXiv:2508.06583. [[File]](./sources/10_discerning_minds_or_generic_tutors_evaluating_inst.md)
11. **Bocconi University / ACL (2025)**. *Educators' Perceptions of Large Language Models as Tutors: Comparing Human and AI Tutors in a Blind Text-only Setting*. **ACL Anthology**, 2025.bea-1.28. [[File]](./sources/11_educators'_perceptions_of_large_language_models_as.md)
12. **Internal Research Synthesis (2026)**. *Empirical Literature on LLM-Based Intelligent Tutoring Systems: Synthesizing Adaptive Scaffolding, Socratic Questioning, and Cognitive Load Dynamics*. Internal Monograph. [[File]](./sources/12_empirical_literature_on_llm-based_intelligent_tuto.md)
13. **MDPI Information (2024)**. *Fluency Illusion: A Review on Influence of ChatGPT in Classroom Settings*. **Information** (MDPI), 17(3), 299. [[File]](./sources/13_fluency_illusion_a_review_on_influence_of_chatgpt_.md)
14. **EdTechBooks Group (2024)**. *Generative AI Peer Tutoring to Support Peer-Reviewed Source Identification and Evaluation*. EdTechBooks Anthology. [[File]](./sources/14_generative_ai_peer_tutoring_to_support_peer-review.md)
15. **Bastani, H., Bastani, O., Sungu, A., Ge, H., Kabakcı, Ö., & Mariman, R. (2025)**. *Generative AI without guardrails can harm learning: Evidence from high school mathematics*. **Proceedings of the National Academy of Sciences (PNAS)**, 122(26), e2422633122. [[File]](./sources/15_generative_ai_without_guardrails_can_harm_learning.md)
16. **Rayuela, D. (2024)**. *How can AI enable real learning?*. Educational Philosophy Journal. [[File]](./sources/16_how_can_ai_enable_real_learning_-_damien_rayuela.md)
17. **CEUR Workshop Proceedings (2023)**. *Hybrid Evaluation of Socratic Dialogue for Teaching*. CEUR-WS.org Vol-3953. [[File]](./sources/17_hybrid_evaluation_of_socratic_dialogue_for_teachin.md)
18. **Emergent Mind Platform (2024)**. *LLM-Powered Tutoring Solutions: Architectural Patterns and Best Practices*. Emergent Mind Research Digest. [[File]](./sources/18_llm-powered_tutoring_solutions_-_emergent_mind.md)
19. **Sesay, J., Yu, Y., Dong, S., Shi, Y., Chen, G., & Karlsson, B. F. (2026)**. *LectūraAgents: A Multi-Agent Framework for Adaptive Personalized AI-Assisted Learning and Embodied Teaching*. arXiv:2606.16428. [[File]](./sources/19_lectraagents_a_multi-agent_framework_for_adaptive_.md)
20. **Chang, Q., Zhang, Z., Chen, L., Hu, P., Zhang, J., Guo, Y., & Du, J. (2026)**. *PEARL: Training Socratic Tutors with Pedagogically Aligned Reinforcement Learning*. arXiv:2605.29582. [[File]](./sources/20_pearl_training_socratic_tutors_with_pedagogically_.md)
21. **ArXiv CS.ED (2024)**. *SBI-RAG: Enhancing Math Word Problem Solving for Students through Schema-Based Instruction and Retrieval-Augmented Generation*. arXiv:2410.13293. [[File]](./sources/21_sbi-rag_enhancing_math_word_problem_solving_for_st.md)
22. **Zabelina, M. (2026)**. *Structured AI Socratic Homework in Higher Education: Implementation, Student Experience, and Evidence from a Pre-Registered Field Study*. **EdArXiv / OSF Preprints**, DOI: 10.35542/osf.io/c3ysd_v1. [[File]](./sources/22_structured_ai_socratic_homework_in_higher_educatio.md)
23. **Yilmaz, R., Karaoğlan Yılmaz, F. G., & Gökoğlu, S. (2024)**. *Student Engagement, Community of Inquiry, and Transactional Distance in Online Learning Environments: A Stepwise Multiple Linear Regression Analysis*. **IRRODL**, 25(1). [[File]](./sources/23_student_engagement,_community_of_inquiry,_and_tran.md)
24. **Xue, Y. et al. (2023)**. *Student perceptions of the community of inquiry framework and satisfaction: Examining the role of academic emotion and self-regulation in a structural model*. **Frontiers in Education**, 8:1046737. [[File]](./sources/24_student_perceptions_of_the_community_of_inquiry_fr.md)
25. **Internal Research Monograph (2026)**. *Systematic Evaluation of Efficacy, Theoretical Frameworks, and Emerging Artificial Intelligence Architectures in Digital Higher Education*. Internal Research Press. [[File]](./sources/25_systematic_evaluation_of_efficacy,_theoretical_fra.md)
26. **Barba, L. (2024)**. *The Illusion of Competence: Insights from Professor Barba*. George Washington University MAE. [[File]](./sources/26_the_illusion_of_competence_insights_from_professor.md)
27. **Minnesota Journal of Business Law (2024)**. *The Illusion of Competence: The Study of Cognitive Offloading in AI-Augmented Management Education*. **Minnesota Journal of Business Law and Entrepreneurship**, 338/259. [[File]](./sources/27_the_illusion_of_competence_the_study_of_cognitive_.md)
28. **SmarterArticles (2024)**. *Twice the Learning, Half the Wisdom: Education in the AI Era*. SmarterArticles EdTech Series. [[File]](./sources/28_twice_the_learning,_half_the_wisdom_education_in_t.md)
29. **Hirji, R. (2023)**. *What is desirable difficulty?*. SuperSkills Research (Robert & Elizabeth Bjork Framework). [[File]](./sources/29_what_is_desirable_difficulty__rahim_hirji_-_supers.md)
30. **Gemini Deep Research Synthesis (2026)**. *The Interplay of Conversational Large Language Models, Socratic Scaffolding, and Cognitive Load: A Comprehensive Analysis of Learning Outcomes, Retention Decoupling, and Multi-Agent Orchestration*. Gemini Notebook Comprehensive Research Synthesis. [[File]](./sources/30_the_interplay_of_conversational_large_language_models.md)
31. **Oreopoulos, P., Liut, M., Sungu, A., & Low, N. (2026)**. *Making AI Tutoring Productive: Evidence from a Mastery-Based Math Practice Experiment*. **EdWorkingPaper No. 26-1552**, Annenberg Institute at Brown University. [[File]](./sources/31_making_ai_tutoring_productive_evidence_from_a_maste.md)
32. **LearnLM Team, Google & Eedi (2025)**. *AI tutoring can safely and effectively support students: An exploratory RCT in UK classrooms*. arXiv:2512.23633. [[File]](./sources/32_ai_tutoring_can_safely_and_effectively_support_stude.md)
33. **Wang, R. E., Ribeiro, A. T., Robinson, C. D., Loeb, S., & Demszky, D. (2024)**. *Tutor CoPilot: A Human-AI Approach for Scaling Real-Time Expertise*. Stanford University / National Student Support Accelerator, arXiv:2410.03017. [[File]](./sources/33_tutor_copilot_a_human-ai_approach_for_scaling_real.md)
34. **Frontiers Research Topic Review (2026)**. *Amplifier or substitute? A systematic review of generative AI's impact on higher-order cognitive skills among university students*. **Frontiers in Psychology**, 17:1863931. [[File]](./sources/34_amplifier_or_substitute_a_systematic_review_of_ge.md)
35. **Vanacore, K., Baker, R. S., Closser, A. H., & Roschelle, J. (2026)**. *The Path to Conversational AI Tutors: Integrating Tutoring Best Practices and Targeted Technologies to Produce Scalable AI Agents*. Cornell University / University of Florida / Digital Promise, arXiv:2602.19303. [[File]](./sources/35_the_path_to_conversational_ai_tutors_integrating.md)
36. **Kumar, H., Mu, Z. K., Vincentius, J., & Anderson, A. (2026)**. *Beyond the AI Tutor: Social Learning with LLM Agents*. University of Toronto, arXiv:2604.02677. [[File]](./sources/36_beyond_the_ai_tutor_social_learning_with_llm_agents.md)
37. **International Medical Education (2026)**. *Assessing Generative AI Adoption, Tool Preferences, and Cognitive Reliance Among Medical Students: A Cross-Sectional Study*. **International Medical Education** (MDPI), 5(3), 66. [[File]](./sources/37_assessing_generative_ai_adoption_tool_preferences.md)
