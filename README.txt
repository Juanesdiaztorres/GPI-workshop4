================================================================================
                      GPI-WORKSHOP4: ANÁLISIS DE DATOS DE SUEÑO
================================================================================

Proyecto de análisis sobre la relación entre el uso del celular antes de dormir
y las horas de sueño.

================================================================================
                                 1. SCRIPTS
================================================================================

Los scripts se encuentran en la carpeta 'codigo/' y deben ejecutarse en el
siguiente orden:

1. 01_simulate_data.Rmd
   - Propósito: Simula datos sobre nombres de personas, horas de sueño y
     minutos antes de dormir en los que dejan de usar el celular
   - Entrada: Ninguna (simulación desde cero)
   - Salida: datos/raw/raw_sleep_data.rds
   - Notas: 
     * Usa semilla 123 para reproducibilidad
     * Genera 30 observaciones con nombres hispanos aleatorios
     * Introduce valores faltantes (missing values) intencionalmente
     * Diseñado para mostrar correlación positiva entre dejar el celular
       más temprano y más horas de sueño

2. 02_processing_and_cleaning_data.Rmd
   - Propósito: Procesa y limpia los datos crudos simulados
   - Entrada: datos/raw/raw_sleep_data.rds
   - Salida: datos/clean/clean_sleep_data.rds
   - Notas:
     * Ajusta tipos de variables (convierte minutos_soltar_cel a entero)
     * Remueve valores faltantes (NA)
     * Verifica coherencia de datos (no tiempos negativos)
     * Reduce las observaciones de 30 a 28 al eliminar NAs

3. 03_exploratory_analysis.Rmd
   - Propósito: Realiza análisis exploratorio de la relación entre uso del
     celular antes de dormir y horas de sueño
   - Entrada: datos/clean/clean_sleep_data.rds
   - Salida: 
     * resultados/scatter_plot.png
     * resultados/model1_results.txt (generado por análisis adicional)
   - Notas:
     * Genera gráfico de dispersión con línea de tendencia lineal
     * Muestra correlación entre variables

================================================================================
                                  2. DATOS
================================================================================

Los datos se encuentran organizados en la carpeta 'datos/' con la siguiente
estructura:

datos/
├── raw/
│   └── raw_sleep_data.rds
│       - Datos crudos simulados (30 observaciones)
│       - Variables:
│         * nombres: nombres de personas (character)
│         * horas_sueno: horas de sueño reportadas (integer, rango 4-8)
│         * minutos_soltar_cel: minutos antes de dormir que dejan el
│           celular (integer, valores: 10, 20, 30, 50, 60)
│       - Contiene 2 valores faltantes (NAs)
│
└── clean/
    └── clean_sleep_data.rds
        - Datos limpios y procesados (28 observaciones)
        - Variables:
          * nombres: nombres de personas (character)
          * horas_sueno: horas de sueño (integer)
          * minutos_soltar_cel: minutos antes de dormir sin celular (integer)
        - Sin valores faltantes
        - Tipos de variables optimizados

================================================================================
                                3. RESULTADOS
================================================================================

Los resultados del análisis se encuentran en la carpeta 'resultados/':

1. scatter_plot.png
   - Gráfico de dispersión que muestra la relación entre minutos sin celular
     antes de dormir y horas de sueño
   - Incluye línea de tendencia lineal
   - Dimensiones: 8x6 pulgadas, 300 DPI
   - Interpretación: Se observa una correlación positiva clara entre dejar
     el celular más temprano y dormir más horas

2. model1_results.txt
   - Resultados de regresión lineal simple
   - Variable dependiente: horas_sueno
   - Variable independiente: minutos_soltar_cel
   - Resultados principales:
     * Coeficiente: 0.074 (t = 33.016, p < 0.001)
     * Intercepto: 3.461 (t = 37.962, p < 0.001)
     * R² = 0.977 (R² ajustado = 0.976)
     * 28 observaciones
   - Interpretación: Por cada minuto adicional antes de dormir sin usar el
     celular, se ganan aproximadamente 0.074 horas (4.4 minutos) de sueño.
     El modelo explica el 97.7% de la variabilidad en las horas de sueño.

================================================================================
                            4. ORDEN DE EJECUCIÓN
================================================================================

Para reproducir completamente el análisis, ejecute los scripts en este orden:

    PASO 1: Abrir el proyecto
    └─→ Abrir el archivo GPI-workshop4.Rproj en RStudio
        (Esto asegura que las rutas relativas funcionen correctamente)

    PASO 2: Simular los datos
    └─→ Ejecutar: codigo/01_simulate_data.Rmd
        Genera: datos/raw/raw_sleep_data.rds

    PASO 3: Limpiar y procesar los datos
    └─→ Ejecutar: codigo/02_processing_and_cleaning_data.Rmd
        Lee: datos/raw/raw_sleep_data.rds
        Genera: datos/clean/clean_sleep_data.rds

    PASO 4: Realizar análisis exploratorio
    └─→ Ejecutar: codigo/03_exploratory_analysis.Rmd
        Lee: datos/clean/clean_sleep_data.rds
        Genera: resultados/scatter_plot.png
                resultados/model1_results.txt (si se ejecuta el modelo)

================================================================================
                              5. REQUISITOS
================================================================================

Paquetes de R necesarios:
  - pacman (para gestión de paquetes)
  - tidyverse (análisis y visualización)
  - randomNames (generación de nombres aleatorios)
  - skimr (estadísticas descriptivas)
  - here (manejo de rutas relativas)

Instalación:
  install.packages("pacman")
  library(pacman)
  p_load(tidyverse, randomNames, skimr, here)

================================================================================
                            6. NOTAS IMPORTANTES
================================================================================

• IMPORTANTE: Siempre abrir el proyecto usando GPI-workshop4.Rproj para que
  las rutas relativas funcionen correctamente con el paquete 'here'

• Los datos son SIMULADOS con propósitos didácticos y no representan
  observaciones reales

• La semilla aleatoria (set.seed(123)) asegura la reproducibilidad de los
  resultados

• El diseño del proceso generador de datos está creado intencionalmente para
  mostrar una fuerte correlación positiva entre las variables

================================================================================
Fecha de creación: Febrero 2026
Curso: GPI - Tercer Semestre MECA
================================================================================