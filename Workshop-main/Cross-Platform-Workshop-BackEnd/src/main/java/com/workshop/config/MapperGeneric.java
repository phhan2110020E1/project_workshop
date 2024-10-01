package com.workshop.config;

import java.lang.reflect.Field;

public class MapperGeneric<T, U> {
    public U ModelmapToDTO(T entity, Class<U> dtoClass) {
        try {
            U dto = dtoClass.newInstance();

            Field[] entityFields = entity.getClass().getDeclaredFields();
            Field[] dtoFields = dtoClass.getDeclaredFields();

            for (Field entityField : entityFields) {
                for (Field dtoField : dtoFields) {
                    if (entityField.getName().equals(dtoField.getName()) &&
                            entityField.getType().equals(dtoField.getType())) {
                        entityField.setAccessible(true);
                        dtoField.setAccessible(true);
                        Object value = entityField.get(entity);
                        dtoField.set(dto, value);
                        entityField.setAccessible(false);
                        dtoField.setAccessible(false);
                    }
                }
            }
            return dto;
        } catch (Exception e) {
            throw new RuntimeException("Error mapping entity to DTO", e);
        }
    }
    public T DTOmapToModel(U dto, Class<T> entityClass) {
        try {
            T entity = entityClass.newInstance();

            Field[] entityFields = entityClass.getDeclaredFields();
            Field[] dtoFields = dto.getClass().getDeclaredFields();

            for (Field entityField : entityFields) {
                for (Field dtoField : dtoFields) {
                    if (entityField.getName().equals(dtoField.getName()) &&
                            entityField.getType().equals(dtoField.getType())) {
                        entityField.setAccessible(true);
                        dtoField.setAccessible(true);
                        Object value = dtoField.get(dto);
                        entityField.set(entity, value);
                        entityField.setAccessible(false);
                        dtoField.setAccessible(false);
                    }
                }
            }
            return entity;
        } catch (Exception e) {
            throw new RuntimeException("Error mapping DTO to entity", e);
        }
    }
}
