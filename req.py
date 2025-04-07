from typing import Union
from uuid import UUID
import requests

activities = [
    # Sirigu
    {
        "tour_sites_region_id": "d0199613-aec4-4e52-be95-026b6deaee07",
        "name": "Pottery workshops",
        "description": "Pottery workshops",
        "price": 0
    },
    {
        "tour_sites_region_id": "d0199613-aec4-4e52-be95-026b6deaee07",
        "name":  "Art demonstrations",
        "description":  "Art demonstrations",
        "price": 0
    },
    {
        "tour_sites_region_id": "d0199613-aec4-4e52-be95-026b6deaee07",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    # Tengzug
    {
        "tour_sites_region_id": "dc0d3414-3028-425e-b200-6fca15339509",
        "name":  "Spiritual tours",
        "description":  "Spiritual tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "dc0d3414-3028-425e-b200-6fca15339509",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    {
        "tour_sites_region_id": "dc0d3414-3028-425e-b200-6fca15339509",
        "name":  "Hiking",
        "description":  "Hiking",
        "price": 0
    },
    # Gwollu
    {
        "tour_sites_region_id": "5837a729-1655-460b-afee-b2cd544cc07d",
        "name":  "Historical tours",
        "description":  "Historical tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "5837a729-1655-460b-afee-b2cd544cc07d",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    {
        "tour_sites_region_id": "5837a729-1655-460b-afee-b2cd544cc07d",
        "name":  "Educational programs",
        "description":  "Educational programs",
        "price": 0
    },
    # Nakore
    {
        "tour_sites_region_id": "d1b5e442-6695-4ce5-b137-d7fee2255a43",
        "name":  "Architectural tours",
        "description":  "Architectural tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "d1b5e442-6695-4ce5-b137-d7fee2255a43",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    {
        "tour_sites_region_id": "d1b5e442-6695-4ce5-b137-d7fee2255a43",
        "name":  "Historical education",
        "description":  "Historical education",
        "price": 0
    },
    # wechiau
    {
        "tour_sites_region_id": "f24bc191-83ba-4eba-b119-b043df621c27",
        "name":  "Hippo viewing",
        "description":  "Hippo viewing",
        "price": 0
    },
    {
        "tour_sites_region_id": "f24bc191-83ba-4eba-b119-b043df621c27",
        "name":  "River safaris",
        "description":  "River safaris",
        "price": 0
    },
    {
        "tour_sites_region_id": "f24bc191-83ba-4eba-b119-b043df621c27",
        "name":  "Bird watching",
        "description":  "Bird watching",
        "price": 0
    },
    {
        "tour_sites_region_id": "f24bc191-83ba-4eba-b119-b043df621c27",
        "name":  "Cultural tours",
        "description":  "Cultural tours",
        "price": 0
    },
    # Amedzofe
    {
        "tour_sites_region_id": "86d0d625-3d83-49df-8fa7-f860a1737d60",
        "name":  "Canopy walks",
        "description":  "Canopy walks",
        "price": 0
    },
    {
        "tour_sites_region_id": "86d0d625-3d83-49df-8fa7-f860a1737d60",
        "name":  "Bird watching",
        "description":  "Bird watching",
        "price": 0
    },
    {
        "tour_sites_region_id": "86d0d625-3d83-49df-8fa7-f860a1737d60",
        "name":  "Nature experiences",
        "description":  "Nature experiences",
        "price": 0
    },
    # Aqua
    {
        "tour_sites_region_id": "290e7f29-d55e-422b-ac2f-3d6b70002188",
        "name":  "Water activities",
        "description":  "Water activities",
        "price": 0
    },
    {
        "tour_sites_region_id": "290e7f29-d55e-422b-ac2f-3d6b70002188",
        "name":  "Safari tours",
        "description":  "Safari tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "290e7f29-d55e-422b-ac2f-3d6b70002188",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    {
        "tour_sites_region_id": "290e7f29-d55e-422b-ac2f-3d6b70002188",
        "name":  "Recreational activities",
        "description":  "Recreational activities",
        "price": 0
    },
    # kpando
    {
        "tour_sites_region_id": "15af0ed4-4e3f-448c-b9c0-7aff9aec3664",
        "name":  "Pottery workshops",
        "description":  "Pottery workshops",
        "price": 0
    },
    {
        "tour_sites_region_id": "15af0ed4-4e3f-448c-b9c0-7aff9aec3664",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    {
        "tour_sites_region_id": "15af0ed4-4e3f-448c-b9c0-7aff9aec3664",
        "name":  "Art demonstrations",
        "description":  "Art demonstrations",
        "price": 0
    },
    # Afadja
    {
        "tour_sites_region_id": "caeeba76-386f-472c-a647-b75ad2ecf8c1",
        "name":  "Mountain hiking",
        "description":  "Mountain hiking",
        "price": 0
    },
    {
        "tour_sites_region_id": "caeeba76-386f-472c-a647-b75ad2ecf8c1",
        "name":  "Village tours",
        "description":  "Village tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "caeeba76-386f-472c-a647-b75ad2ecf8c1",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    # Tafi atome
    {
        "tour_sites_region_id": "32d3d797-f2a6-4c69-bfd7-67457aee7108",
        "name":  "Monkey viewing",
        "description":  "Monkey viewing",
        "price": 0
    },
    {
        "tour_sites_region_id": "32d3d797-f2a6-4c69-bfd7-67457aee7108",
        "name":  "Guided tours",
        "description":  "Guided tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "32d3d797-f2a6-4c69-bfd7-67457aee7108",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    {
        "tour_sites_region_id": "32d3d797-f2a6-4c69-bfd7-67457aee7108",
        "name":  "Night entertainment",
        "description":  "Night entertainment",
        "price": 0
    },
    # wli
    {
        "tour_sites_region_id": "85675642-4327-43ab-8b77-804a529cb747",
        "name":  "Waterfall viewing",
        "description":  "Waterfall viewing",
        "price": 0
    },
    {
        "tour_sites_region_id": "85675642-4327-43ab-8b77-804a529cb747",
        "name":  "Hiking",
        "description":  "Hiking",
        "price": 0
    },
    {
        "tour_sites_region_id": "85675642-4327-43ab-8b77-804a529cb747",
        "name":  "Cultural tours",
        "description":  "Cultural tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "85675642-4327-43ab-8b77-804a529cb747",
        "name":  "Nature experiences",
        "description":  "Nature experiences",
        "price": 0
    },
    # Bia
    {
        "tour_sites_region_id": "38f712e0-f9e4-45c9-bc9b-4fb5e6e37f50",
        "name":  "Wildlife safaris",
        "description":  "Wildlife safaris",
        "price": 0
    },
    {
        "tour_sites_region_id": "38f712e0-f9e4-45c9-bc9b-4fb5e6e37f50",
        "name":  "Bird watching",
        "description":  "Bird watching",
        "price": 0
    },
    {
        "tour_sites_region_id": "38f712e0-f9e4-45c9-bc9b-4fb5e6e37f50",
        "name":  "Nature walks",
        "description":  "Nature walks",
        "price": 0
    },
    # Akatekyi
    {
        "tour_sites_region_id": "80e619d3-d5b9-4375-bf3f-46054153612e",
        "name":  "Crocodile viewing",
        "description":  "Crocodile viewing",
        "price": 0
    },
    {
        "tour_sites_region_id": "80e619d3-d5b9-4375-bf3f-46054153612e",
        "name":  "Cultural tours",
        "description":  "Cultural tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "80e619d3-d5b9-4375-bf3f-46054153612e",
        "name":  "Nature experiences",
        "description":  "Nature experiences",
        "price": 0
    },
    # Busua
    {
        "tour_sites_region_id": "8fd62cdf-c67e-4bfd-b468-ba91b67636c9",
        "name":  "Beach activities",
        "description":  "Beach activities",
        "price": 0
    },
    {
        "tour_sites_region_id": "8fd62cdf-c67e-4bfd-b468-ba91b67636c9",
        "name":  "Water sports",
        "description":  "Water sports",
        "price": 0
    },
    {
        "tour_sites_region_id": "8fd62cdf-c67e-4bfd-b468-ba91b67636c9",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    # Batenstein
    {
        "tour_sites_region_id": "c9cb3620-e834-4a9c-a0ba-c6553d551a32",
        "name":  "Historical tours",
        "description":  "Historical tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "c9cb3620-e834-4a9c-a0ba-c6553d551a32",
        "name":  "Ocean views",
        "description":  "Ocean views",
        "price": 0
    },
    {
        "tour_sites_region_id": "c9cb3620-e834-4a9c-a0ba-c6553d551a32",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    # Orange
    {
        "tour_sites_region_id": "3ee41010-b3fb-4416-8032-413016274cbf",
        "name":  "Historical tours",
        "description":  "Historical tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "3ee41010-b3fb-4416-8032-413016274cbf",
        "name":  "Guided visits",
        "description":  "Guided visits",
        "price": 0
    },
    {
        "tour_sites_region_id": "3ee41010-b3fb-4416-8032-413016274cbf",
        "name":  "Coastal views",
        "description":  "Coastal views",
        "price": 0
    },
    {
        "tour_sites_region_id": "3ee41010-b3fb-4416-8032-413016274cbf",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    # Aberwa
    {
        "tour_sites_region_id": "3aca6941-dcd9-45a0-97d0-5416caef51c3",
        "name":  "Historical exhibits",
        "description":  "Historical exhibits",
        "price": 0
    },
    {
        "tour_sites_region_id": "3aca6941-dcd9-45a0-97d0-5416caef51c3",
        "name":  "Guided tours",
        "description":  "Guided tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "3aca6941-dcd9-45a0-97d0-5416caef51c3",
        "name":  "Cultural education",
        "description":  "Cultural education",
        "price": 0
    },
    {
        "tour_sites_region_id": "3aca6941-dcd9-45a0-97d0-5416caef51c3",
        "name":  "Architectural appreciation",
        "description":  "Architectural appreciation",
        "price": 0
    },
    # Ankasa
    {
        "tour_sites_region_id": "0e3f7162-52ea-4d9a-81ab-031dfa306f16",
        "name":  "Bird watching",
        "description":  "Bird watching",
        "price": 0
    },
    {
        "tour_sites_region_id": "0e3f7162-52ea-4d9a-81ab-031dfa306f16",
        "name":  "Hiking",
        "description":  "Hiking",
        "price": 0
    },
    {
        "tour_sites_region_id": "0e3f7162-52ea-4d9a-81ab-031dfa306f16",
        "name":  "Rock climbing",
        "description":  "Rock climbing",
        "price": 0
    },
    # Cape three
    {
        "tour_sites_region_id": "c6af1bce-b837-4984-89c3-8ce00328217c",
        "name":  "Nature walks",
        "description":  "Nature walks",
        "price": 0
    },
    {
        "tour_sites_region_id": "c6af1bce-b837-4984-89c3-8ce00328217c",
        "name":  "Lighthouse visits",
        "description":  "Lighthouse visits",
        "price": 0
    },
    {
        "tour_sites_region_id": "c6af1bce-b837-4984-89c3-8ce00328217c",
        "name":  "Wildlife viewing",
        "description":  "Wildlife viewing",
        "price": 0
    },
    # Nzulezu
    {
        "tour_sites_region_id": "5ab49b29-e024-4f3b-995c-91ff1fed14b1",
        "name":  "Canoe rides",
        "description":  "Canoe rides",
        "price": 0
    },
    {
        "tour_sites_region_id": "5ab49b29-e024-4f3b-995c-91ff1fed14b1",
        "name":  "Village tours",
        "description":  "Village tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "5ab49b29-e024-4f3b-995c-91ff1fed14b1",
        "name":  "Cultural experiences",
        "description":  "Cultural experiences",
        "price": 0
    },
    # The fort metal cross
    {
        "tour_sites_region_id": "5cb884f8-e150-408e-a9e3-ea52774c5c0a",
        "name":  "Historical tours",
        "description":  "Historical tours",
        "price": 0
    },
    {
        "tour_sites_region_id": "5cb884f8-e150-408e-a9e3-ea52774c5c0a",
        "name":  "Ocean views",
        "description":  "Ocean views",
        "price": 0
    },
    {
        "tour_sites_region_id": "5cb884f8-e150-408e-a9e3-ea52774c5c0a",
        "name":  "Cultural engagement",
        "description":  "Cultural engagement",
        "price": 0
    },
    {
        "tour_sites_region_id": "5cb884f8-e150-408e-a9e3-ea52774c5c0a",
        "name":  "Community interaction",
        "description":  "Community interaction",
        "price": 0
    },

]

headers = {
    "Content-Type": "application/json",
    # "X-CSRF-Token": "",
    "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NDA0OTg0NzUsImlkIjoiZmIxNWRlM2ItNzUyNi00NmE2LWE5NmMtYTk2ZTg3ODIwNTQ4IiwiZW1haWwiOiJvbHV3YXRvYmkuYWd1bmxveWVAYnRtbGltaXRlZC5uZXQiLCJuYW1lIjoiVG9iaSBMaWdodCIsImlzX2FkbWluIjp0cnVlfQ.u69Syh_IA_uaWbHZOgFqFS80Ojr9pUbloZPzIEOlxMg",
}

for activity in activities:
    request = requests.post(
        "http://127.0.0.1:8000/api/activity/add", json=activity, headers=headers)

    print(request.status_code, request.json())
