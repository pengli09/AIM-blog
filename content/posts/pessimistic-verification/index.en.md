---
title: "Pessimistic Verification: Helping LLMs Check Mathematical Proofs"
date: 2026-05-17
authors:
description: "We present Pessimistic Verification, a simple and efficient way to improve LLM-based verification for open-ended mathematical proofs."
tags: ["AI4Math", "LLM", "Math Verification", "ICML 2026"]
categories: ["Research Highlights"]
ShowToc: false
TocOpen: true
cover:
  image: "figures/pessimistic_verifiers.svg"
  alt: "Overview of Pessimistic Verification"
  caption: "Pessimistic verification focuses on finding proof errors: if any verifier detects a critical flaw, the proof is rejected."
  hiddenInSingle: true
---

For mathematical agents, solving problems is only half of the story. They also need to check whether a proof is actually correct. Verification is central to iterative problem-solving workflows and to reinforcement learning for open-ended mathematical reasoning.

Our ICML 2026 paper, **Pessimistic Verification for Open-Ended Math Questions**, studies a simple principle: when verifying a mathematical proof, the bottleneck is usually error detection. Instead of asking multiple reviewers to vote, we ask them to look for flaws. If any reviewer finds a critical error, the proof should be rejected.

<!--more-->

## Why Be Pessimistic?

Open-ended math problems rarely come with a final answer that can be checked by a simple rule. A proof may look plausible while hiding a subtle gap in a lemma, transformation, or boundary case. For LLM verifiers, the hard part is often not accepting correct proofs, but catching the mistakes in incorrect ones.

This makes majority voting a poor fit for proof verification. If an error is hard to find, most reviewers may miss it, and voting can suppress the one useful negative judgment. Pessimistic verification takes the opposite view: a well-supported error report is strong evidence.

## Three Verification Schemes

![Three forms of pessimistic verification](figures/pessimistic_verifiers.svg)
*Figure 1 | Three pessimistic verification schemes studied in the paper.*

We study three variants:

1. **Simple Pessimistic Verification** checks the whole proof several times in parallel and rejects it if any run finds an error.
2. **Vertical Pessimistic Verification** splits the proof into chunks and asks the model to inspect each local segment more carefully.
3. **Progressive Pessimistic Verification** starts with whole-proof checks, filters out obvious failures, and then progressively subdivides the remaining proofs for finer inspection.

Progressive verification performs best in our experiments. It avoids spending a high local-checking budget on every proof from the start, while still drilling down when a proof survives coarse review.

![Chunk-level review prompting](figures/vertical_review_prompting.svg)
*Figure 2 | Chunk-level review focuses the verifier on local proof details.*

## What We Found

We evaluate on IMO-GradingBench, Hard2Verify, and QiuZhen-Bench using TPR, TNR, and Balanced F1. Across datasets and models, progressive pessimistic verification consistently improves error detection and usually improves Balanced F1.

One important finding is that some apparent false negatives from strong models are not really mistakes. After manual review, many false negative cases from GPT-5-mini, GPT-5, and Gemini 3 Pro Preview turned out to be real critical errors that the original annotations had missed. This suggests that current proof-verification benchmarks may already underestimate frontier model performance.

Progressive verification is also much more efficient. In our auxiliary measurements on GPT-5-mini, `prog@3/6` reaches 0.85 Balanced F1 with about 7.1K equivalent output tokens per sample. A simple parallel setting, `pes@12`, reaches 0.87 Balanced F1 but uses about 35.7K equivalent output tokens. At a comparable performance level, progressive verification uses roughly one quarter of the tokens, runtime, and API cost.

## From Verification to Solving

Pessimistic verification can also be plugged into an iterative problem-solving workflow: generate a proof, verify it, use feedback to revise it, and repeat.

![Verification-assisted solving workflow](figures/simple_workflow.svg)
*Figure 3 | A verification-assisted iterative solving workflow.*

On IMO 2025, Gemini 3 Pro Preview scores 13 points with direct solving, 17 points with simple pessimistic verification, and 22 points with progressive pessimistic verification, while progressive verification uses fewer tokens than the simple parallel scheme. On the harder MathArena Apex 2025 set, progressive verification also shows a better accuracy-cost curve.

## Takeaway

The main lesson is straightforward: for mathematical proofs, reliability comes from sensitivity to errors. A useful verifier does not only need to align with human scores; it needs to find the key gaps that make a proof fail.

Pessimistic verification is not a substitute for formal proof checking, but it offers a practical, low-cost, and scalable mechanism for natural-language mathematics. As reasoning models improve, this kind of verification may become a core component of mathematical agents, AI-assisted research, and open-ended math reinforcement learning.

📄 **Read the paper PDF:** [Pessimistic Verification for Open-Ended Math Questions](pessimistic-verification.pdf)

💻 **Code:** [THUNLP-MT/pverify](https://github.com/THUNLP-MT/pverify)
