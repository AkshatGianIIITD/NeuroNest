# **Neuronest: Early Detection of Cognitive Decline**

**Neuronest** is a mobile-first, AI-powered application designed for the early detection and continuous monitoring of cognitive decline in elderly individuals. By combining a user-friendly interface with a robust dual-modality assessment engine, Neuronest aims to democratize access to cognitive health monitoring, making it proactive rather than reactive.

## **👥 Team Members**

* **Akshat Gian** (2022051)  
* **Kunal** (2022260)

## **🎯 The Problem**

The global population of individuals aged 65 and over is growing rapidly, and with it, the prevalence of dementia is projected to triple by 2050\. A significant challenge in managing cognitive disorders is the delay in detection. Early-stage cognitive decline is often missed until substantial and irreversible neuron loss has occurred.

Current challenges with standard clinical tests (like MoCA and MMSE) include:

* **Infrequency:** Tests are conducted too sporadically to track subtle, longitudinal changes.  
* **Accessibility:** They require specialist administration, limiting access in rural or low-income areas.  
* **Bias:** Results can be influenced by cultural and language differences.  
* **Lack of Continuous Data:** One-off tests fail to capture the day-to-day fluctuations and gradual decline in cognitive function.

There is a clear need for a scalable, user-friendly, and continuous monitoring tool for community-dwelling seniors.

## **✨ Our Solution: NeuroNest**

Neuronest addresses this gap with a multimodal mobile application that combines two powerful assessment methods to boost sensitivity and specificity.

1. **MCQ Cognitive Quiz:** A series of adaptive questions based on validated clinical instruments (MoCA & MMSE) that assess memory, executive function, and attention. The difficulty adjusts to the user's performance to maintain engagement.  
2. **Speech-Based Analysis:** A 90-second free-speech prompt (e.g., "Describe what you see in the image") is analyzed by a fine-tuned NLP model to extract critical biomarkers like lexical richness, pause patterns, and semantic coherence.

This dual-modality approach provides a daily cognitive "health score," allowing users, caregivers, and clinicians to track cognitive function over time through an intuitive interface.

## **🚀 Key Features**

* **Dual-Modality Assessment:** Combines cognitive quizzes and speech analysis for a comprehensive evaluation.  
* **Daily Tracking:** Provides a daily cognitive score to visualize trends and subtle changes over time.  
* **Adaptive Quizzes:** Questions adjust in difficulty to keep users engaged and accurately measured.  
* **Objective & Scalable:** Automated scoring removes manual grading and subjectivity.  
* **User-Friendly:** Designed with seniors in mind, featuring a simple UI, voice guidance, and minimal training required.  
* **Admin Dashboard:** Allows caregivers or clinicians to monitor the progress of multiple users.

## **🖼️ App Demo & Screenshots**

**Live Demo:** [**View the App Demo on Google Drive**](https://drive.google.com/file/d/1vGbvziJ4bIQpvKHRV0F6SaTSNdbrrvtq/view?usp=sharing)

| Cognitive Test (MCQ) | Voice Screening Test |
| :---- | :---- |
| \<img src="[https://storage.googleapis.com/gemini-prod/images/4094a4c5-3428-4903-b778-98e983488732](https://www.google.com/search?q=https://storage.googleapis.com/gemini-prod/images/4094a4c5-3428-4903-b778-98e983488732)" alt="MCQ test screen" width="250"/\> | \<img src="[https://storage.googleapis.com/gemini-prod/images/483ef396-8576-47a3-875f-5573719001b9](https://www.google.com/search?q=https://storage.googleapis.com/gemini-prod/images/483ef396-8576-47a3-875f-5573719001b9)" alt="Voice test screen" width="250"/\> |

| Cognitive Model Chat Interface |
| :---- |
| \<img src="[https://storage.googleapis.com/gemini-prod/images/4014d3f3-524f-4d2c-850f-e68516087b29](https://www.google.com/search?q=https://storage.googleapis.com/gemini-prod/images/4014d3f3-524f-4d2c-850f-e68516087b29)" alt="Cognitive model chat" width="500"/\> |

## **🛠️ Methodology & Tech Stack**

### **Data Pipeline: Voice-to-Cognition**

Our system follows a clear data pipeline to generate a cognitive assessment from a user's speech.

\<img src="[https://storage.googleapis.com/gemini-prod/images/737e4244-93e5-4089-a228-5695029e2f9f](https://www.google.com/search?q=https://storage.googleapis.com/gemini-prod/images/737e4244-93e5-4089-a228-5695029e2f9f)" alt="Data pipeline diagram" width="700"/\>

### **Model Architecture**

* **Frontend:** Flutter  
* **Speech-to-Text Engine:** Whisper, Wav2Vec2  
* **Base NLP Model:** bert-base-uncased / BERT-large  
* **Fine-Tuning:** The model was fine-tuned on a custom SQuAD-formatted dataset created from 200 speech recordings of healthy, MCI, and early-stage Alzheimer's patients.  
* **QA Head:** A linear layer was added to the base model to predict the start and end positions of answer spans for cognitive assessment.

### **Training Procedure**

* **Epochs:** 3  
* **Batch Size:** 16  
* **Learning Rate:** 3e-5  
* **Optimizer:** AdamW  
* **Max Sequence Length:** 384 tokens  
* **Environment:** NVIDIA Tesla V100 GPU

## **📈 User Testing & Feedback**

The application was tested with 5 elderly individuals (aged 65-80) over a 2-week period.

* **Key Finding:** All participants found the app intuitive and easy to navigate, with a **100% task completion rate** without assistance.  
* **Feedback:** Users appreciated the simple interface. Based on feedback, we increased font sizes for better accessibility and added a brief onboarding tutorial.

## **🔭 Future Scope**

* **Expand Dataset:** Incorporate more diverse languages, accents, and demographics.  
* **Add Features:** Implement daily reminders and an in-app doctor consultation feature.  
* **Personalization:** Customize tests based on user history and performance.  
* **Clinical Partnerships:** Partner with hospitals and clinics for real-world deployment and validation.

## **🤝 Contributions**

* **Literature Review, Research & UI Design:** Ashwin Verma, Arun Singh Rawat  
* **Dataset Creation, Model Training & Deployment:** Kunal, Dhairya  
* **Flutter App Development & API Integration:** Akshat Gian, Kunal Dangi