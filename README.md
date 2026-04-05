# TBD Course – Notes & Project

<p align="center">
  <img src="https://media.giphy.com/media/..." width="250"/>
</p>

## 🌸 About the Course

This repository contains my notes and work for the course **Taller de Base de Datos (Database Workshop - TBD)**, taught by **Ing. Juan Marcelo Flores Soliz**.

The purpose of this repository is to document, organize, and reinforce the concepts learned throughout the course, with a strong focus on **database idioms and data modeling techniques**.

---

## 🌸 Project Overview

The main project models a **personal repository system oriented to mobile devices**.

### Problem

When users change their mobile devices, they often lose important information such as:

* Photos
* Audio files
* Text documents
* App configurations (e.g., WhatsApp, Telegram)

This occurs due to the absence of an organized and reliable backup system.

---

### Solution

The proposed system allows a **user** to store and manage files within **personal repositories**.

Each file contains the following attributes:

* Type
* Size
* Owner
* Storage date

---

### Data Modeling Approach

The system applies **specialization (inheritance)** in the data model:

* **Multimedia files** (images, audio, etc.)
* **Application configuration files**

Each specialized entity includes attributes specific to its nature, which do not apply to other file types.

---

## 🌸 Repository Structure

### ProyectoNetbeans

This folder contains the main application developed in Java.

* The project must be opened and executed using Apache NetBeans
* It includes the implementation of the system described above
* Make sure your Java environment is properly configured before running

---

### database

This folder contains the database scripts and related resources.

* Designed to work with PostgreSQL
* Can be managed using pgAdmin 4
* Includes the necessary structure to set up the database for the project

---

### apuntes

This folder contains personal notes and study material for the course.

* Includes summaries and key concepts
* Focused on database idioms and modeling practices

---

## 🌸 Learning Objectives

* Apply database modeling concepts to real-world problems
* Understand entity relationships and specialization
* Strengthen system design and abstraction skills

---

## 🌸Requirements

To run this project properly, you should have:

* Java
* Apache NetBeans
* PostgreSQL
* pgAdmin 4
