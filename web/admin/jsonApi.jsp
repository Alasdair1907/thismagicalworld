<%@page trimDirectiveWhitespaces="true"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="org.hibernate.SessionFactory" %>
<%@ page import="world.thismagical.entity.AuthorEntity" %>
<%@ page import="world.thismagical.service.FileHandlingService" %>
<%@ page import="world.thismagical.to.*" %>
<%@ page import="world.thismagical.util.JsonApi" %>
<%@ page import="world.thismagical.util.Tools" %>
<%@ page import="world.thismagical.vo.*" %>
<%@ page import="java.util.List" %>
<%@ page import="world.thismagical.filter.BasicPostFilter" %>
<%@ page import="world.thismagical.filter.BasicFileFilter" %>
<%@ page import="world.thismagical.service.PagingService" %>
<%@ page import="org.hibernate.Session" %>
<%@ page import="world.thismagical.filter.PagingRequestFilter" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="world.thismagical.test.PagingTest" %>
<%@ page import="com.fasterxml.jackson.core.type.TypeReference" %>
<%@ page import="java.lang.reflect.Type" %>
<%@ page import="world.thismagical.util.ServletUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    SessionFactory sessionFactory = ServletUtils.getSessionFactory(application);

    ObjectMapper objectMapper = new ObjectMapper();

    if (request.getParameter("action") != null){

        String action = request.getParameter("action");
        String data = request.getParameter("data");
        String guid = request.getParameter("guid");
        String location = request.getSession().getServletContext().getRealPath("/");

        Tools.log("admin/jsonApi: action: "+action);

        // authorization

        if (action.equals("verifySessionGuid")){
            JsonAdminResponse<Void> res = JsonApi.verifySessionGuid(data, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("authorize")){
            AuthVO authVO = objectMapper.readValue(data, AuthVO.class);
            JsonAdminResponse<AuthorizedVO> res = JsonApi.authorize(authVO.login, authVO.passwordHash, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("authorizeDemo")){
            JsonAdminResponse<AuthorizedVO> res = JsonApi.authorizeDemo(sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        // authors edit

        if (action.equals("listAllAuthorsVO")){
            JsonAdminResponse<List<AuthorVO>> res = JsonApi.listAllAuthorsVO(sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("listPrivileges")){
            JsonAdminResponse<List<PrivilegeVO>> res = JsonApi.listPrivileges();
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("createNewAuthor")){
            AuthorEntity newAuthor = objectMapper.readValue(data, AuthorEntity.class);
            JsonAdminResponse<Void> res = JsonApi.createNewAuthor(guid, newAuthor, location, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("changePassword")){
            ChangeAuthorDataRequest changePasswordRequest = objectMapper.readValue(data, ChangeAuthorDataRequest.class);
            JsonAdminResponse<Void> res = JsonApi.changePassword(guid, changePasswordRequest.targetAuthorId, changePasswordRequest.newPassword, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("changeDisplayName")){
            ChangeAuthorDataRequest changePasswordRequest = objectMapper.readValue(data, ChangeAuthorDataRequest.class);
            JsonAdminResponse<Void> res = JsonApi.changeDisplayName(guid, changePasswordRequest.targetAuthorId, changePasswordRequest.newDisplayName, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("changeAccessLevel")){
            ChangeAuthorDataRequest changePasswordRequest = objectMapper.readValue(data, ChangeAuthorDataRequest.class);
            JsonAdminResponse<Void> res = JsonApi.changeAccessLevel(guid, changePasswordRequest.targetAuthorId, changePasswordRequest.newAccessLevelId, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("deleteUser")){
            Long userId = Long.parseLong(data);
            JsonAdminResponse<Void> res = JsonApi.deleteAuthor(guid, userId, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        // author profile

        if (action.equals("getAuthorVOByGuid")){
            JsonAdminResponse<AuthorVO> res = JsonApi.getAuthorVOByGuid(guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getAuthorVOByLogin")){
            JsonAdminResponse<AuthorVO> res = JsonApi.getAuthorVOByLogin(data, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("updateAuthorProfile")){
            AuthorVO authorVO = objectMapper.readValue(data, AuthorVO.class);
            JsonAdminResponse<Void> res = JsonApi.updateAuthorProfile(guid, authorVO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        // photos edit

        if (action.equals("saveOrUpdatePhoto")){
            PhotoTO photoTO = objectMapper.readValue(data, PhotoTO.class);
            JsonAdminResponse<Long>  res = JsonApi.saveOrUpdatePhoto(photoTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("listAllPhotoVOs")){
            BasicPostFilterTO basicPostFilterTO = null;
            if (data != null && !data.isEmpty()){
                basicPostFilterTO = objectMapper.readValue(data, BasicPostFilterTO.class);
            }
            JsonAdminResponse<List<PhotoVO>> res = JsonApi.listAllPhotoVOsFilter(basicPostFilterTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getPhotoVOByPhotoId")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<PhotoVO> res = JsonApi.getPhotoVOByPhotoId(id, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getPhotoImageVO")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<ImageVO> res = JsonApi.getPhotoImageVO(id, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("togglePhotoPublish")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<Void> res = JsonApi.togglePhotoPublish(id, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("deletePhoto")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<Void> res = JsonApi.deletePhoto(id, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        // tag editor

        if (action.equals("listTags")){
            TagTO tagTO = objectMapper.readValue(data, TagTO.class);
            JsonAdminResponse<TagTO> res = JsonApi.listTagsForObject(tagTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("saveOrUpdateTags")){
            TagTO tagTO = objectMapper.readValue(data, TagTO.class);
            JsonAdminResponse<Void> res = JsonApi.saveOrUpdateTags(tagTO, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        // homepage widget - lists only tags for published posts
        if (action.equals("getTagDigestVOList")){
            JsonAdminResponse<List<TagDigestVO>> res = JsonApi.getTagDigestVOList(sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        // gallery edit

        if (action.equals("listAllGalleryVOs")){
            BasicPostFilterTO basicPostFilterTO = null;
            if (data != null && !data.isEmpty()){
                basicPostFilterTO = objectMapper.readValue(data, BasicPostFilterTO.class);
            }

            JsonAdminResponse<List<GalleryVO>> res = JsonApi.listAllGalleryVOsFilter(basicPostFilterTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("saveOrUpdateGallery")){
            GalleryTO galleryTO = objectMapper.readValue(data, GalleryTO.class);
            JsonAdminResponse<Long>  res = JsonApi.saveOrUpdateGallery(galleryTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getGalleryVOByGalleryId")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<GalleryVO> res = JsonApi.getGalleryVOByGalleryId(id, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("toggleGalleryPublish")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<Void> res = JsonApi.toggleGalleryPublish(id, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("deleteGallery")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<Void> res = JsonApi.deleteGallery(id, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        // image manager

        if (action.equals("listImageVOs")){
            ImageUploadTO imageTO = objectMapper.readValue(data, ImageUploadTO.class);
            JsonAdminResponse<List<ImageVO>> res = JsonApi.listImageVOs(imageTO.imageAttributionClass, imageTO.parentObjectId, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("deleteFileEntity")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<Void> res = FileHandlingService.deleteFile(id, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("updateFileDescription")){
            ImageFileDescrTO imageFileDescrTO = objectMapper.readValue(data, ImageFileDescrTO.class);
            JsonAdminResponse<Void> res = FileHandlingService.updateFileInfo(imageFileDescrTO, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getImageFileDescrTO")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<ImageFileDescrTO> res = FileHandlingService.getImageFileDescrTO(id, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }
        
        // articles edit

        if (action.equals("saveOrUpdateArticle")){
            ArticleTO articleTO = objectMapper.readValue(data, ArticleTO.class);
            JsonAdminResponse<Long>  res = JsonApi.saveOrUpdateArticle(articleTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("listAllArticleVOs")){
            BasicPostFilterTO basicPostFilterTO = null;
            if (data != null && !data.isEmpty()){
                basicPostFilterTO = objectMapper.readValue(data, BasicPostFilterTO.class);
            }
            JsonAdminResponse<List<ArticleVO>> res = JsonApi.listAllArticleVOsFilter(basicPostFilterTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getArticleVOByArticleId")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<ArticleVO> res = JsonApi.getArticleVOByArticleId(id, false, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getArticleVOByArticleIdPreprocessed")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<ArticleVO> res = JsonApi.getArticleVOByArticleId(id, true, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getArticleTitleImageVO")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<ImageVO> res = JsonApi.getArticleTitleImageVO(id, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("toggleArticlePublish")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<Void> res = JsonApi.toggleArticlePublish(id, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("deleteArticle")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<Void> res = JsonApi.deleteArticle(id, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("setArticleTitleImageId")){
            ArticleTO articleTO = objectMapper.readValue(data, ArticleTO.class);
            JsonAdminResponse<Void> res = JsonApi.setArticleTitleImageId(articleTO, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        // relations

        if (action.equals("listRelationsForPost")){
            PostTO postTO = objectMapper.readValue(data, PostTO.class);
            JsonAdminResponse<RelationTO> res = JsonApi.listRelationsForPost(postTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("createNewRelation")){
            RelationVO relationVoPartial = objectMapper.readValue(data, RelationVO.class);
            JsonAdminResponse<Void> res = JsonApi.createNewRelation(guid, relationVoPartial, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("deleteRelation")){
            Long relationId = Long.parseLong(data);
            JsonAdminResponse<Void> res = JsonApi.deleteRelation(guid, relationId, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }
        
        if (action.equals("listConcernedArticlesVOs")){
            PostTO postTO = objectMapper.readValue(data, PostTO.class);
            JsonAdminResponse<List<ArticleVO>> res = JsonApi.listConcernedArticlesVOs(postTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("listConcernedPhotosVOs")){
            PostTO postTO = objectMapper.readValue(data, PostTO.class);
            JsonAdminResponse<List<PhotoVO>> res = JsonApi.listConcernedPhotosVOs(postTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("listConcernedGalleryVOs")){
            PostTO postTO = objectMapper.readValue(data, PostTO.class);
            JsonAdminResponse<List<GalleryVO>> res = JsonApi.listConcernedGalleryVOs(postTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        // key value service - settings etc.

        if (action.equals("saveKeyValue")){
            KeyValueTO keyValueTO = objectMapper.readValue(data, KeyValueTO.class);
            JsonAdminResponse<Void> res = JsonApi.saveKeyValue(keyValueTO, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("loadKeyValue")){
            JsonAdminResponse<KeyValueTO> res = JsonApi.getKeyValue(data, guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("saveSettings")){
            SettingsTO settingsTO = objectMapper.readValue(data, SettingsTO.class);
            JsonAdminResponse<Void> res = JsonApi.saveSettings(guid, settingsTO, sessionFactory);

            if (res.success){
                application.setAttribute("settingsTO", null);
            }

            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getSettingsAuthed")){
            JsonAdminResponse<SettingsTO> res = JsonApi.getSettingsAuthed(guid, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getSettingsNoAuth")){
            JsonAdminResponse<SettingsTO> res = JsonApi.getSettingsNoAuth(sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getAboutPreprocessed")){
            JsonAdminResponse<String> res = JsonApi.getAboutPreprocessed(sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        // non-image files

        if (action.equals("listOtherFiles")){
            BasicFileFilter basicFileFilter = objectMapper.readValue(data, BasicFileFilter.class);
            JsonAdminResponse<List<OtherFileVO>> res = FileHandlingService.listOtherFiles(basicFileFilter, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("deleteOtherFile")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<Void> res = FileHandlingService.deleteOtherFile(guid, id, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getOtherFileById")){
            Long id = Long.parseLong(data);
            JsonAdminResponse<OtherFileVO> res = FileHandlingService.getOtherFileById(id, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("updateOtherFileInfo")){
            OtherFileTO otherFileTO = objectMapper.readValue(data, OtherFileTO.class);
            JsonAdminResponse<Void> res = FileHandlingService.updateOtherFileInfo(otherFileTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        // cda

        if (action.equals("processPagingRequest")){
            PagingRequestFilter pagingRequestFilter = objectMapper.readValue(data, PagingRequestFilter.class);
            JsonAdminResponse<PostVOList> res = JsonApi.processPagingRequest(pagingRequestFilter, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("processPagingRequestUnified")){
            PagingRequestFilter pagingRequestFilter = objectMapper.readValue(data, PagingRequestFilter.class);
            JsonAdminResponse<PostVOListUnified> res = JsonApi.processPagingRequestUnified(pagingRequestFilter, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("getSidePanelPosts")){
            SidePanelRequestTO sidePanelRequestTO = objectMapper.readValue(data, SidePanelRequestTO.class);
            JsonAdminResponse<SidePanelPostsTO> res = JsonApi.getSidePanelPosts(sidePanelRequestTO, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("preFilterTags")){
            PagingRequestFilter pagingRequestFilter = objectMapper.readValue(data, PagingRequestFilter.class);
            JsonAdminResponse<List<String>> res = JsonApi.preFilterTags(pagingRequestFilter, sessionFactory);
            out.print(JsonApi.toString(res, objectMapper));
        }

        /*
        if (action.equals("test")){
            PagingTest.test(sessionFactory);
        }*/


        if (action.equals("toBase64Utf8")){
            JsonAdminResponse<String> res = JsonAdminResponse.success(JsonApi.toBase64(data));
            out.print(JsonApi.toString(res, objectMapper));
        }

        if (action.equals("fromBase64Utf8")){
            JsonAdminResponse<String> res = JsonAdminResponse.success(JsonApi.fromBase64(data));
            out.print(JsonApi.toString(res, objectMapper));
        }
    }
%>