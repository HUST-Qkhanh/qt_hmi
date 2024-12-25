import QtQuick
import QtQuick3D

Node {
    id: node

    // Resources

    // Nodes:
    Node {
        id: forklift_obj
        objectName: "forklift.obj"
        Model {
            id: plane_003
            objectName: "Plane.003"
            source: "meshes/plane_003_mesh.mesh"
            materials: [
                material_003_material,
                material_material
            ]
        }
        Model {
            id: plane_002
            objectName: "Plane.002"
            source: "meshes/plane_002_mesh.mesh"
            materials: [
                material_003_material,
                material_material
            ]
        }
        Model {
            id: plane_001
            objectName: "Plane.001"
            source: "meshes/plane_001_mesh.mesh"
            materials: [
                material_003_material,
                material_material
            ]
        }
        Model {
            id: plane_000
            objectName: "Plane.000"
            source: "meshes/plane_000_mesh.mesh"
            materials: [
                material_003_material,
                material_material
            ]
        }
        Model {
            id: sphere
            objectName: "Sphere"
            source: "meshes/sphere_mesh.mesh"
            materials: [
                material_002_material
            ]
        }
        Model {
            id: plane_009
            objectName: "Plane.009"
            source: "meshes/plane_009_mesh.mesh"
            materials: [
                material_001_material,
                material_003_material
            ]
        }
        Model {
            id: plane_008
            objectName: "Plane.008"
            source: "meshes/plane_008_mesh.mesh"
            materials: [
                material_001_material,
                material_003_material,
                material_material
            ]
        }
    }

    Node {
        id: __materialLibrary__

        PrincipledMaterial {
            id: material_003_material
            objectName: "Material.003"
            baseColor: "#ff999999"
            indexOfRefraction: 1
        }

        PrincipledMaterial {
            id: material_material
            objectName: "Material"
            baseColor: "#ff999999"
            indexOfRefraction: 1
        }

        PrincipledMaterial {
            id: material_002_material
            objectName: "Material.002"
            baseColor: "#ff999999"
            indexOfRefraction: 1
        }

        PrincipledMaterial {
            id: material_001_material
            objectName: "Material.001"
            baseColor: "#ff999999"
            indexOfRefraction: 1
        }
    }

    // Animations:
}

/*##^##
Designer {
    D{i:0;cameraSpeed3d:25;cameraSpeed3dMultiplier:1;matPrevEnvDoc:"SkyBox";matPrevEnvValueDoc:"preview_studio";matPrevModelDoc:"#Sphere"}
}
##^##*/
