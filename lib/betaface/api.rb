module Betaface
  class Api
    include Betaface::REST

    attr_reader :client

    ##
    # Do nothing for now
    def initialize(*args)
      @client ||= Betaface::REST::Client.new(*args) 
    end

    #############################
    #                           #
    #         RESOURCES         #
    #                           #
    #############################


    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/FaceInfo_Delete
    # Delete image and faces information
    # Note to the API dev: a REST DELETE instead of a POST is recommended
    def face_info_delete(face_uid)
      @client.post "/service_json_ssl.svc/FaceInfo_Delete", {face_uid:face_uid}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/FaceInfo_New
    # Tag new info about a face in an picture/image
    def face_info_new(img_uid, faceinfo = {})
      @client.post "/service_json_ssl.svc/FaceInfo_New", {img_uid:img_uid,faceinfo:faceinfo}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/FaceInfo_SetFaceImagePoints
    def face_info_set_face_image_points(face_uid, points = [])
      @client.post "/service_json_ssl.svc/FaceInfo_SetFaceImagePoints", {face_uid:face_uid,points:points}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/FaceInfo_SetPoints
    def face_info_set_points(face_uid, points = [])
      @client.post "/service_json_ssl.svc/FaceInfo_SetPoints", {face_uid:face_uid,points:points}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/FaceInfo_SetTags
    def face_info_set_tags(face_uid, tags = [])
      @client.post "/service_json_ssl.svc/FaceInfo_SetTags", {face_uid:face_uid,tags:tags}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/FaceInfo_Update
    # Update info about a face in an picture/image
    def face_info_update(face_uid, faceinfo = {})
      @client.post "/service_json_ssl.svc/FaceInfo_Update", {face_uid:face_uid,faceinfo:faceinfo}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/GetFaceImage
    # Retrieve cropped face image and points coordinates in cropped face image coordinates
    def get_face_image(face_uid)
      @client.post "/service_json_ssl.svc/GetFaceImage", {face_uid:face_uid}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/GetImageFileInfo
    # Retrieve image and faces information or processing status using image file SHA-256 hash code
    def get_image_file_info(img_checksum)
      @client.post "/service_json_ssl.svc/GetImageFileInfo", {img_checksum:img_checksum}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/GetImageInfo
    # Retrieve image and faces information or processing status 
    def get_image_info(img_uid)
      @client.post "/service_json_ssl.svc/GetImageInfo", {img_uid:img_uid}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/GetRecognizeResult
    # Get results of recognition request or processing status 
    def get_recognize_result(recognize_uid)
      @client.post "/service_json_ssl.svc/GetRecognizeResult", {recognize_uid:recognize_uid}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/GetTransformResult
    # Get results of transform request or processing status
    def get_transform_result(transform_uid)
      @client.post "/service_json_ssl.svc/GetTransformResult", {transform_uid:transform_uid}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/GetVerifyResult
    def get_verify_result(verify_string)
      @client.post "/service_json_ssl.svc/GetVerifyResult", {verify_string:verify_string}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/RecognizeFaces
    # Execute recognition request for each of face ids and specified list of targets 
    # (comma separated list either of face ids, or persons and namespaces as name@namespace.com or all@namespace.com)
    def recognize_faces(faces_uids, targets, params)
      @client.post "/service_json_ssl.svc/RecognizeFaces", {faces_uids:faces_uids,targets:targets,parameters:params}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/SetPerson
    # Assign person name (John Doe@mynamespace.com) to one or more face ids
    def set_person(faces_uids, person_id)
      @client.post "/service_json_ssl.svc/SetPerson", {faces_uids:faces_uids,person_id:person_id}
    end

    ##
    # Assign person name (John Doe@mynamespace.com) to one or more face ids
    # https://www.betafaceapi.com/service_json_ssl.svc/TransformFaces
    def transform_faces(action, faces_points, faces_uids, params)
      @client.post "/service_json_ssl.svc/TransformFaces", {faces_uids:faces_uids,action:action,faces_points:faces_points,parameters:params}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/UploadImage
    # Upload image url or base64 encoded string
    # detection flags: propoints,classifiers,extended
    # TODO Upload image file
    def upload_image(detection_flags, image = {})
      params = {detection_flags:detection_flags}
      params[:url] = image[:url] if image[:url].present?
      params[:original_filename] = image[:url].split("/")[-1] if image[:url].present? and image[:original_filename].blank?
      params[:image_base64] = image[:base64] if image[:base64].present?
      @client.post "/service_json_ssl.svc/UploadImage", params
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/UploadNewImage_File
    # detection flags: propoints,classifiers,extended
    # Upload image file as Base64Binary encoded string
    # TODO Need to be fixed on the API Server
    def upload_new_image_file(detection_flags, image = {})
      @client.post "/service_json_ssl.svc/UploadNewImage_File", {detection_flags:detection_flags,imagefile_data:image[:data],original_filename:image[:original_filename]}
    end

    ##
    # https://www.betafaceapi.com/service_json_ssl.svc/UploadNewImage_Url
    # detection flags: propoints,classifiers,extended
    # Upload image url
    # TODO Need to be fixed on the API Server
    def upload_new_image_url(detection_flags, image = {})
      params = {detection_flags:detection_flags}
      params[:url] = image[:url] if image[:url].present?
      params[:original_filename] = image[:url].split("/")[-1] if image[:url].present? and image[:original_filename].blank?
      @client.post "/service_json_ssl.svc/UploadNewImage_Url", params
    end

  end
end
