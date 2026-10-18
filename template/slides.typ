#import "@local/if-presentation:0.1.0": *

#show: if-theme.with(
  aspect-ratio: "16-9",
  progress-bar: true,
  badge-label: [ICAICTA 2026],
  font-style: "academic", // "academic" | "cute" | "modern" | "formal"
  config-info(
    title: [Lightweight Adaptive Vision Transformers for Low-Power Edge Devices],
    subtitle: [Oral Presentation · Paper ID \#128],
    author: [First Author & Second Author],
    institution: [Departemen Teknik Informatika, Institut Teknologi Sepuluh Nopember],
    date: [October 21, 2026],
  ),
)

// --- Cover Slide ---
#title-slide(
  conference: [ICAICTA 2026],
  paper-id: "128",
  session: [Oral Session 3: Computer Vision & AI],
  tags: ([Edge AI], [Vision Transformer], [Inference Optimization]),
  tag-style: "kicker",
  variant: "white", // try "blue" or "dark" as well!
)

// --- Presentation Roadmap ---
#outline-slide()

// ==========================================
= Background & Problem Formulation
// ==========================================

== Research Motivation

Deploying modern deep vision models to resource-constrained embedded edge platforms poses significant challenges:

- *Compute Bottleneck*: High floating-point operations (FLOPs) saturate edge NPUs and microcontrollers.
- *Thermal & Memory Limits*: Memory bandwidth limits throughput far more than compute capability.
- *Real-time Requirements*: Latency must strictly remain below $20 "ms"$ for closed-loop robotic control.

#v(0.4em)

#split[
  #stat-card("3.8x", "Parameter Bloat", subtext: [Overhead in vanilla ViT models], color: if-blue)
][
  #stat-card("< 15ms", "Target Latency", subtext: [Required for 60 FPS feedback], color: if-gold-dark)
][
  #stat-card("85%", "Energy Saved", subtext: [Via dynamic token pruning], color: rgb("#16A34A"))
]

#note("Emphasize the edge deployment dilemma between latency and parameter accuracy.")

== Research Questions

We formalize our investigation into two primary research questions:

#research-question("1", title: [Adaptive Token Pruning])[
  Can spatial token redundancy in self-attention layers be pruned dynamically at runtime without compromising semantic classification accuracy?
]

#research-question("2", title: [Hardware-Aware Quantization])[
  How does 8-bit integer post-training quantization interact with mixed-precision attention heads on embedded edge NPUs?
]

// ==========================================
= Proposed Methodology
// ==========================================

== Architectural Pipeline

Our proposed framework introduces a three-stage compression and runtime adaptation strategy:

#step("1", title: [Dynamic Saliency Scoring])[
  Compute token importance scores via cross-layer attention rollouts to identify uninformative spatial patches.
]

#step("2", title: [Progressive Token Pruning & Merging])[
  Merge spatially coherent tokens rather than outright discarding them, preserving background contextual cues.
]

#step("3", title: [Hardware-Aware Mixed Precision Quantization])[
  Quantize linear projection weights to INT8 while keeping critical softmax operations in FP16.
]

== Method Details & Implementation

#split[
  #cblock(title: [Key Architectural Innovation], type: "method")[
    - Token merging preserves boundary features
    - Zero retraining needed for dynamic pruning ratios
    - Native support for TensorRT & ONNX Runtime
  ]
][
  #cblock(title: [Deployment Considerations], type: "tip")[
    - Linear memory footprint during inference
    - Guaranteed deterministic execution budgets
    - Seamless fallback for edge CPU targets
  ]
]

#v(0.2em)

#quote-block(
  [Efficiency is not merely an optimization detail; it determines whether intelligent systems can exist in physical reality.],
  author: [Edge Computing Principles],
)

// ==========================================
= Experimental Evaluation
// ==========================================

== Benchmark Comparison

We evaluated our method against baseline models on standard benchmarks:

#comparison-slide(
  title: [Performance Comparison: Baseline vs Proposed],
  left-title: [Standard Vision Transformer (ViT-B/16)],
  right-title: [Proposed Adaptive ViT (Ours)],
  [
    - *Top-1 Accuracy*: $81.8%$
    - *Throughput*: $42 "fps"$ on RTX 4060
    - *Edge Latency*: $48.2 "ms"$ (Jetson Orin Nano)
    - *Memory Usage*: $345 "MB"$
    - *Energy Draw*: $12.8 "W"$ average
  ],
  [
    - *Top-1 Accuracy*: *$81.4%$* ($-0.4%$ negligible drop)
    - *Throughput*: *$118 "fps"$* (*$2.8 times$ speedup*)
    - *Edge Latency*: *$13.6 "ms"$* (*Real-time compliant*)
    - *Memory Usage*: *$98 "MB"$* (*$71%$ reduction*)
    - *Energy Draw*: *$4.2 "W"$* (*$67%$ energy saved*)
  ],
)

== Key Findings & Ablation

#split[
  #cblock(title: [Accuracy Retention], type: "result")[
    + Retains $> 99.5%$ of baseline accuracy across 5 distinct vision benchmarks.
    + Robust against noisy sensory inputs and camera motion blur.
  ]
][
  #cblock(title: [Hardware Generalization], type: "info")[
    - Tested across Jetson Nano, Raspberry Pi 5, and RK3588.
    - Achieves sub-$15 "ms"$ latency on all platforms.
  ]
]

#v(0.5em)

#split[
  #metric-card("2.8x", "Speedup", subtext: [Over unpruned baseline], color: if-blue)
][
  #metric-card("-71%", "RAM Usage", subtext: [Peak runtime allocation], color: rgb("#16A34A"))
][
  #metric-card("13.6 ms", "Edge Latency", subtext: [On Jetson Orin Nano], color: if-gold-dark)
]

// --- Dark Standout Focus Slide ---
#focus-slide(title: [Takeaway Message])[
  Adaptive token merging unlocks real-time Vision Transformer deployment on $5 "W"$ edge hardware without accuracy degradation.
]

// ==========================================
= Conclusion & Future Work
// ==========================================

== Summary of Contributions

#split[
  #cblock(title: [Core Contributions], type: "result")[
    - Novel saliency-guided token merging formulation.
    - Zero-retraining dynamic runtime adaptation.
    - Empirical validation on edge robotic hardware.
    - Open-source PyTorch & TensorRT implementation.
  ]
][
  #cblock(title: [Future Directions], type: "challenge")[
    - Extend to multi-modal vision-language models (VLMs).
    - Investigate temporal token recycling in video streams.
    - Test on ultra-low-power neuromorphic processors.
  ]
]

// --- Closing Slide with Contact & Q&A ---
#thank-you-slide(
  title: [Terima Kasih / Thank You],
  subtitle: [Q&A & Discussion],
  author: [First Author & Second Author],
  email: "author@informatika.its.ac.id",
  repo: "github.com/its-if/adaptive-vit-edge",
  paper-link: "doi.org/10.1109/ICAICTA.2026.xxxxxx",
  quote: [Code is like humor; when you have to explain it, it’s probably not that good.],
  variant: "blue",
)
