--******************************************************************************************************
-- Organización: Rimac
-- Programa: Migración AS400 y VUL a Acsel-e
-- Creado por: 
-- Fecha Creación: 
-- Propósito: Obtención de las coberturas
-- Fuentes de datos: Capa Raw
-- Proceso : Staging
-- Historial de Modificaciones
-- Autor            fecha             Detalle
--======================================================================================================
-- Victor Usuy     13/11/2024         Adición de los cruces de tabla con pólizas migradas
-- Kevin Tacco	   04/12/2024         Limpieza de codigo comentado CM 1125206
--******************************************************************************************************

SELECT periodo, ----
des_producto
  ,tip_documento_afiliado
  ,num_documento_afiliado
  ,nom_completo_afiliado
  ,des_grupo_contratante grupo_contratante
  ,nom_completo_contratante contratantes
  ,fec_ocurrencia 
  ,fec_liquidacion as fec_ultima_liquidacion
  ,num_siniestro
  ,num_documento_contratante as RUC
  ,num_poliza as nro_poliza
  ,trim(nom_razon_social_proveedor) as proveedor_razon_comercial
  ,cod_beneficio_cobertura cod_beneficio
  ,des_beneficio_cobertura des_cobertura
  ,num_diagnostico_origen cod_diagnostico
	,des_diagnostico_salud -- nuevo
  ,des_diagnostico_salud 
  ,mnt_planilla_afiliado_sol mnt_planilla_afi_sinistro
  ,mnt_coaseguro_sol_sin_igv mnt_coaseguro_ats
  ,mnt_beneficio_pagado_sol_sin_igv mnt_beneficio_sol
FROM --`rs-shr-al-analyticsz-prj-ebc1.delivery_experiencia_al_cliente.cr_siniestro_ocurrido_salud` f
`rs-nprd-dlk-data-rwz-51a6.bdsoportegcp__sbx.cr_siniestro_ocurrido_salud` f
--where  --nom_completo_afiliado like '%JOAQUIN BERRIO%'
where 1=1 and id_estado_siniestro_origen in ('4','8') and
(
CASE
      WHEN num_documento_contratante = '20161749126' AND des_beneficio_cobertura LIKE '%(CAPITACION)%' THEN '1'
      ELSE '0'
    END ='0')  

and num_documento_afiliado='92996336'

ORDER BY num_siniestro
