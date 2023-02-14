# CG-Midterm
Practical component for the Intermediate Computer Graphics Midterm

## Realistic Texture Shader

Features:

- Normal mapping, with customizable normal strength
- Albedo map

The first shader I choose was the bump map shader, to make the ship look realistic without modifying the mesh, I choose this because I thought it would greately improve the visual fidelity of the scene, without requiring me create a mesh with a lot of polygons. This shader's implementation was fairly straightforward, in a surface shader we are simply sampling an albedo map which we apply as the colour of the mesh, and sampling a normal map which we apply as the normals of the mesh. To increase or decrease the normal strength, we are multiplying the normal's r and g values with a user defined normal strength parameter, and lerping between 1 and the normal map's original b value by the same strength paramter.

Normal mapping ON

![Screenshot (454)](https://user-images.githubusercontent.com/86686062/218820649-2902f331-abe2-459a-8aea-62b96cdadbd1.png)


Normal mapping OFF
![Screenshot (455)](https://user-images.githubusercontent.com/86686062/218820793-1d32ca4f-1b9c-4492-b738-c51d9afc28c8.png)


Pseudocode:

output.Albedo = AlbedoMap.rbg;
output.Normal = new float3(NormalStrength * NormalMap.r, NormalStrength * NormalMap.g, lerp(1, NormalMap.b, NormalStrength));

I did not use any lab code for this shader, but I did consult Unity documentation for information on how to do normal strength, https://docs.unity3d.com/Packages/com.unity.shadergraph@7.3/manual/Normal-Strength-Node.html

## Forcefield Shader

Features:

- Normal mapping
- Rim lighting
- Rim alpha effect

The second shader I choose was the forcefield shader, I choose this because I thought the forcefield effect would look really good with the spaceship and therefore improve the visual fidelity of the scene. This shader's implementation is also fairly straightforward, the normal mapping is implemented the same as the first shader, but with no normal strength value, and the forcefield effect is done by checking how similar the view direction is to a face's normal, if it was similar, then we apply more alpha and less emission, but if it wasn't similar (close to perpendicular) then we apply less alpha and more emission.

Pseudocode:

output.Normal = NormalMap.rgb;
output.Alpha = pow(1 - dot(lightDir, Normal), RimPower);
output.Emission = pow(1 - dot(lightDir, Normal), RimPower);

I also did not use any lab code for this shader, and I did not consult any resources either.


## External Resources

Ship textures, normal and albedo : https://polyhaven.com/a/metal_plate
Forcefield textures, normal and albedo : https://polyhaven.com/a/hexagonal_concrete_paving

All external textures are located in the resources folder.
