################################################################################
#                GPI-WORKSHOP4: RUNALL                       #
################################################################################

if (!require("pacman")) install.packages("pacman")
pacman::p_load(rmarkdown, here, tidyverse)

cat("\n--- Iniciando ejecución con generación de Logs (HTML) ---\n")

# Crear carpeta de logs si no existe. Esto es para guardar los HTML que se generan
if(!dir.exists(here("resultados", "logs"))) {
  dir.create(here("resultados", "logs"), recursive = TRUE)
}

tryCatch({
  
  # PASO 1: Simulación
  # Definimos la ruta justo antes de usarla para que no se pierda
  path1 <- here("codigo", "01_simulate_data.Rmd")
  cat("\n[1/3] Renderizando Simulación...\n")
  rmarkdown::render(path1, 
                    output_dir = here("resultados", "logs"), 
                    envir = globalenv(), 
                    quiet = TRUE)
  
  # PASO 2: Limpieza
  path2 <- here("codigo", "02_processing_and_cleaning_data.Rmd")
  cat("[2/3] Renderizando Limpieza y Procesamiento...\n")
  rmarkdown::render(path2, 
                    output_dir = here("resultados", "logs"), 
                    envir = globalenv(), 
                    quiet = TRUE)
  
  # PASO 3: Análisis
  path3 <- here("codigo", "03_exploratory_analysis.Rmd")
  cat("[3/3] Renderizando Análisis y Modelos...\n")
  rmarkdown::render(path3, 
                    output_dir = here("resultados", "logs"), 
                    envir = globalenv(), 
                    quiet = TRUE)
  
  cat("\n====================================================")
  cat("\n✅ ¡ÉXITO! Proyecto ejecutado.")
  cat("\nLos reportes HTML están en: resultados/logs/")
  cat("\n====================================================\n")
  
}, error = function(e) {
  cat("\n❌ ERROR ENCONTRADO:\n", e$message, "\n")
})
