#!/bin/bash
author='walker'
projectname='FamilyDoctor'
passkeys='code,flag,message'
fileuri='/Users/walker/Desktop/index.html'
offset=1
debug=true
verbose=false
modulename='taskCommon'
httpclient='PMLRESTBaseDoctor'
models=(
#地区列表
modelAreaListItem,modelAreaJuniorDOListItem
#获取图片验证码
#医生其他端获取手机验证码
#医生APP获取手机验证码
#医院搜索
modelHospitalSearchResult,modelHospitalSearchResultItem
#医院详情
modelHospitalDetail
#科室搜索
modelHospitalDeptSearchResult,modelDeptSearchResultItem
#科室详情
modelHospitalDeptDetail
#医生搜索
modelDoctorSearchResult,modelDoctorSearchResultItem
#医生（专家）详情
modelDoctorDetail,modelDoctorDeptListItem
#疾病搜索
modelDieaseSearchResult,modelDieaseSearchResultItem
#套餐列表
modelServicePkgListPlainItem
#药品搜索
modelMedicineSearchResultItem
#kanoServer


)

for model in ${models[@]}; do
    types=${types}${model},
done
types=${types}

if [ "$debug" = true ] ; then
    enableDebug='--debug'
fi

if [ "$verbose" = true ] ; then
    enableVerbose='--verbose'
fi

./app.js ${enableVerbose} ${enableDebug} \
    -C ${types} \
    -P ${passkeys} \
    -f ${fileuri} \
    -a ${author} \
    -m ${modulename} \
    -j ${projectname} \
    -B ${httpclient} \
    -o ${offset}
